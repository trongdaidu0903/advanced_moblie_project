import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/schedule/schedule.dart';

class BookingDetailView extends StatefulWidget {
  const BookingDetailView({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  State<BookingDetailView> createState() => _BookingDetailViewState();
}

class _BookingDetailViewState extends State<BookingDetailView> {
  String weekdayConverter(int weekday) {
    String result = '';

    switch (weekday) {
      case 1:
        result = 'Monday';
        break;
      case 2:
        result = 'Tuesday';
        break;
      case 3:
        result = 'Wednesday';
        break;
      case 4:
        result = 'Thursday';
        break;
      case 5:
        result = 'Friday';
        break;
      case 6:
        result = 'Saturday';
        break;
      case 7:
        result = 'Sunday';
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)!.settings.arguments as Map;
    // final String time = data['selectedHour'];
    // final String date = data['selectedDate'].toString().substring(0, 11);
    // final String weekday = weekdayConverter(data['weekday']);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Booking Details',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking Time',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Center(
            //   child: Text(
            //     '$time\n$weekday $date',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 22, color: Colors.blue[800]),
            //   ),
            // ),
            const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Balance',
            //         style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     const Text(
            //       'You have 1 lesson left',
            //       style: TextStyle(fontSize: 17, color: Colors.blue),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Price',
            //         style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     const Text(
            //       '1 lesson',
            //       style: TextStyle(fontSize: 17, color: Colors.blue),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16),
            Text('Notes',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  final currentContext = context;
                  // Create an asynchronous function to handle the dialog and navigation
                  Future<void> handleDialogAndNavigation() async {
                    final dialogResult =
                        await showBookingResultDialog(currentContext);
                    if (dialogResult) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(currentContext);
                    }
                  }

                  // Call the asynchronous function
                  await handleDialogAndNavigation();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'BOOK',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> showBookingResultDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Booking Success'),
        content:
            const Text('You can now study with this tutor at booked time.'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
