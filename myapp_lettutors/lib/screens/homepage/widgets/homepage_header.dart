import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp_lettutors/models/schedule/booking_info.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/user_service.dart';
import 'package:provider/provider.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader({Key? key}) : super(key: key);

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  late Duration totalLessonTime;
  BookingInfo? upcomingClass;

  bool _isLoading = true;

  Future<void> _fetchTotalLessonTime(String token) async {
    try {
      log("👌[Info] Fetching total lesson time");
      final total = await UserService.getTotalLessonTime(token);
      final upcoming = await UserService.getUpcomingLesson(token);

      if (mounted) {
        setState(() {
          totalLessonTime = Duration(minutes: total);
          upcomingClass = upcoming;
          _isLoading = false;
        });
      }
    } catch (e) {
      log("😡[Error] ${e.toString()}");
    }
  }

  String _convertTotalLessonTime() {
    if (totalLessonTime.inMinutes == 0) {
      return 'You have not attended any class';
    }

    String result = 'Total Lesson Time:';

    final int hour = totalLessonTime.inHours;
    final int minute = totalLessonTime.inMinutes - hour * 60;
    result += hour > 0 ? ' $hour ${hour > 1 ? 'hours' : 'hour'}' : '';
    result += minute > 0 ? ' $minute ${minute > 1 ? 'minutes' : 'minute'}' : '';

    return result;
  }

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 110, 100),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _isTimeToJoin() {
    final startTimestamp =
        upcomingClass?.scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final startTime = DateTime.fromMillisecondsSinceEpoch(startTimestamp);
    final now = DateTime.now();

    if (now.isBefore(startTime)) {
      showSnackBar('This lesson has not started yet');
      return true;
    }

    return true;
  }

  void _joinMeeting() async {
    final String meetingToken =
        upcomingClass?.studentMeetingLink?.split('token=')[1] ?? '';

    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];
    log(room);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      log(accessToken);
      _fetchTotalLessonTime(accessToken);
    }

    return Container(
      color: const Color.fromARGB(255, 38, 117, 197),
      width: double.maxFinite,
      height: 208,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Column(
              children: [
                if (upcomingClass != null) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Upcoming Lesson',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    '${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(upcomingClass?.scheduleDetailInfo?.startPeriodTimestamp ?? 0))} '
                    '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(upcomingClass?.scheduleDetailInfo?.startPeriodTimestamp ?? 0))} - '
                    '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(upcomingClass?.scheduleDetailInfo?.endPeriodTimestamp ?? 0))}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          if (_isTimeToJoin()) {
                            _joinMeeting();
                          }
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.ondemand_video_rounded),
                            SizedBox(width: 12),
                            Text('Enter Lesson Room',
                                style: TextStyle(fontSize: 14)),
                          ],
                        )),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Text(
                    _convertTotalLessonTime(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
    );
  }
}

class VideoCallView {}
