import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp_lettutors/constants/items_per_page.dart';
import 'package:myapp_lettutors/models/schedule/booking_info.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/user_service.dart';
import 'package:provider/provider.dart';

import '../widgets/upcoming_card.dart';

class UpcomingView extends StatefulWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  State<UpcomingView> createState() => _UpcomingClassViewState();
}

class _UpcomingClassViewState extends State<UpcomingView> {
  List<BookingInfo> upcoming = [];

  final int _page = 1;
  final int _perPage = itemsPerPage.first;
  bool _isLoading = true;

  Future<void> _fetchUpcomingClasses(String token) async {
    final result = await UserService.getAllUpcomingClasses(
      token: token,
      page: _page,
      perPage: _perPage,
    );

    setState(() {
      upcoming = result['classes'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchUpcomingClasses(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'You have 10 upcoming classes',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                ...List<Widget>.generate(
                  5,
                  (index) => UpcomingClassCard(
                    bookingInfo: BookingInfo(
                      createdAtTimeStamp: DateTime.now().millisecondsSinceEpoch,
                      updatedAtTimeStamp: DateTime.now().millisecondsSinceEpoch,
                      id: "null id",
                      userId: "userId",
                      scheduleDetailId: "scheduleDetailId",
                      tutorMeetingLink: "",
                      studentMeetingLink: "",
                      studentRequest: "Request from student",
                      tutorReview: "Tutor review",
                      scoreByTutor: 3,
                      createdAt: DateFormat().add_yMEd().format(DateTime.now()),
                      updatedAt: DateFormat().add_yMEd().format(DateTime.now()),
                      recordUrl: "",
                      isDeleted: false,
                      scheduleDetailInfo: null,
                      classReview: null,
                    ),
                    onCancel: (value) {
                      if (value) {
                        setState(() {
                          _isLoading = true;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
  }
}
