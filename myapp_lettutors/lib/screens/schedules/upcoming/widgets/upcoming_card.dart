import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp_lettutors/models/schedule/booking_info.dart';

class UpcomingClassCard extends StatelessWidget {
  const UpcomingClassCard(
      {Key? key, required this.bookingInfo, required this.onCancel})
      : super(key: key);

  final BookingInfo bookingInfo;
  final Function(bool cancelResult) onCancel;

  void _joinMeeting() async {
    Map<String, Object> featureFlags = {};
    final String meetingToken =
        bookingInfo?.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String roomUrl = jwtDecoded['room'];
    try {
      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomUrl,
        serverUrl: "https://meet.lettutor.com",
        subject:
            "Meeting with ${bookingInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name}",
        userDisplayName: "Enter Display Name",
        userAvatarUrl:
            'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg',
        isAudioOnly: false,
        isAudioMuted: false,
        isVideoMuted: false,
        featureFlags: featureFlags,
      );
      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (e) {
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(top: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.access_alarms_sharp,
                      size: 32,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                                .name ??
                            "null name",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat.yMMMEd().format(
                            DateTime.fromMillisecondsSinceEpoch(bookingInfo
                                    .scheduleDetailInfo?.startPeriodTimestamp ??
                                0)),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   DateFormat().add_yMEd().format(DateTime.now()),
                      //   style: const TextStyle(fontSize: 15),
                      // ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await showEditRequestDialog(context);
                  },
                  icon: Icon(
                    Icons.edit_note_outlined,
                    size: 32,
                    color: Colors.blue[700],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel class'),
                          content:
                              const Text('Are you sure to cancel this class?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _joinMeeting();
                    },
                    child: const Text(
                      'Go to meeting',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> showEditRequestDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Requests For Lesson'),
        content: TextField(
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10))),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

Future<bool> showWaitingRoomDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('It is not the time yet'),
      content: const Text(
          'Do you want to enter meeting room right now, or enter waiting room?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Waiting Room'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Meeting Room'),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
