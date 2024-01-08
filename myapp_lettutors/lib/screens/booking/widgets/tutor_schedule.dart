import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp_lettutors/dummy/dummy_data.dart';
import 'package:myapp_lettutors/screens/booking/views/booking_hour_view.dart';
import 'package:myapp_lettutors/models/schedule/schedule.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/booking_service.dart';
import 'package:provider/provider.dart';

class TutorSchedule extends StatefulWidget {
  const TutorSchedule({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<TutorSchedule> createState() => _TutorScheduleState();
}

class _TutorScheduleState extends State<TutorSchedule> {
  AuthProvider get _authProvider => context.read<AuthProvider>();

  List<Schedule> schedules = [];
  List<int> scheduleStartTimestamps = [];
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now().add(const Duration(days: 10));
  bool _isLoading = false;
  void onDateRangePickerTap() {
    final year = DateTime.now().year;

    showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      firstDate: DateTime(year - 5),
      lastDate: DateTime(year + 5),
      initialDateRange: DateTimeRange(
        start: _selectedStartDate,
        end: _selectedEndDate,
      ),
      builder: (_, child) {
        return DatePickerTheme(
          data: DatePickerThemeData(
            dayBackgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: child,
            ),
          ),
        );
      },
    ).then((selectedRangeDate) {
      setState(() {
        _selectedStartDate = selectedRangeDate?.start ?? _selectedStartDate;
        _selectedEndDate = selectedRangeDate?.end ?? _selectedEndDate;
        if (_authProvider.token?.access?.token?.isNotEmpty ?? false) {
          Future.delayed(Duration.zero, () async {
            await _fetchTutorSchedule(_authProvider.token!.access!.token!);
          });
        }
      });
    });
  }

  Future<void> _fetchTutorSchedule(String token) async {
    setState(() {
      _isLoading = true;
    });
    List<Schedule> result = await BookingService.getTutorScheduleById(
      token: token,
      userId: widget.userId,
      startDate: _selectedStartDate.millisecondsSinceEpoch,
      endDate: _selectedEndDate.millisecondsSinceEpoch,
    );

    // Remove all learning dates before today
    result = result.where((schedule) {
      if (schedule.startTimestamp == null) return false;

      //final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);

      // bool isTheSameDate = now.day == start.day && now.month == start.month && now.year == start.year;
      return start.isAfter(DateTime.now());
    }).toList();

    // Sort learning DateTime increasingly
    result.sort((s1, s2) {
      if (s1.startTimestamp == null || s2.startTimestamp == null) return 0;
      return s1.startTimestamp!.compareTo(s2.startTimestamp!);
    });

    schedules = result;

    final timestamps =
        schedules.map((schedule) => schedule.startTimestamp ?? 0).toList();

    for (var timestamp in timestamps) {
      //bool isExisted = false;
      if (!scheduleStartTimestamps.any((element) {
        final date1 = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final date2 = DateTime.fromMillisecondsSinceEpoch(element);

        bool isTheSameDate = date1.day == date2.day &&
            date1.month == date2.month &&
            date1.year == date2.year;
        if (isTheSameDate) {
          return true;
        }
        return false;
      })) {
        scheduleStartTimestamps.add(timestamp);
      }
    }
    scheduleStartTimestamps.sort();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    if (_authProvider.token?.access?.token?.isNotEmpty ?? false) {
      Future.delayed(Duration.zero, () async {
        await _fetchTutorSchedule(_authProvider.token!.access!.token!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _authProvider.token != null) {
      final String accessToken = _authProvider.token?.access?.token as String;
      _fetchTutorSchedule(accessToken);
    }

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 0),
                    child: Text(
                      'Choose Learning Date',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  TextButton(
                      onPressed: onDateRangePickerTap,
                      child: Text(
                          "${DateFormat().add_yMEd().format(_selectedStartDate)} -  ${DateFormat().add_yMEd().format(_selectedEndDate)}")),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(24),
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 32,
                      childAspectRatio: 3,
                      children: List<Widget>.generate(
                        scheduleStartTimestamps.length,
                        (index) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[300],
                          ),
                          onPressed: () async {
                            await Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return BookingHourView(
                                  schedules: schedules,
                                  timestamp: scheduleStartTimestamps[index],
                                );
                              },
                            ));
                            _fetchTutorSchedule(
                                _authProvider.token!.access!.token!);
                          },
                          child: Text(
                            DateFormat.MMMEd().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    scheduleStartTimestamps[index])),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Future<DateTime?> _bookLearningDate(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
  return selectedDate ?? DateTime.now();
}

// Future<void> _bookLearningHour(
//     BuildContext context, DateTime selectedDate) async {
//   await showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     elevation: 5,
//     clipBehavior: Clip.hardEdge,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(16),
//       ),
//     ),
//     builder: (context) {
//       return SafeArea(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.75,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 32, bottom: 8),
//                 child: Text(
//                   'Choose Your Time',
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ),
//               Expanded(
//                 child: GridView.count(
//                   padding: const EdgeInsets.all(24),
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 24,
//                   crossAxisSpacing: 32,
//                   childAspectRatio: 3,
//                   children: List<Widget>.generate(
//                     courseHours.length,
//                     (index) => ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                       ),
//                       onPressed: () async {
//                         // final dialogResult =
//                         //     await _showBookingConfirmDialog(context);
//                         // if (dialogResult) {
//                         //   // ignore: use_build_context_synchronously
//                         //   Navigator.of(context).pushNamed(
//                         //     Routes.bookingDetail,
//                         //     arguments: {
//                         //       'selectedDate': selectedDate,
//                         //       'selectedHour': courseHours[index],
//                         //       'weekday': selectedDate.weekday
//                         //     },
//                         //   );
//                         // }
//                       },
//                       child: Text(
//                         courseHours[index],
//                         style:
//                             const TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

Future<bool> _showBookingConfirmDialog(
    BuildContext context, Schedule schedule) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Book This Tutor'),
        content: Column(
          children: [
            const Text('Booking time'),
            Text(DateFormat.yMMMMEEEEd().format(
                DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!))),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('YES')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
