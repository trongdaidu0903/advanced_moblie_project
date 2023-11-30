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
                  10,
                  (index) => UpcomingClassCard(
                    bookingInfo: BookingInfo(
                      createdAtTimeStamp: DateTime.now().millisecondsSinceEpoch,
                      updatedAtTimeStamp: DateTime.now().millisecondsSinceEpoch,
                      id: "22f9e210-a712-43f8-b73c-8a036583c0ec",
                      userId: "37264873-797b-473d-bf4c-fb017fec076f",
                      scheduleDetailId: "022d0e8d-5957-4dd9-8a2e-862d34f7e0c9",
                      tutorMeetingLink:
                          "/call/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJuaGlsYW01MjkyQGdtYWlsLmNvbSIsIm5hbWUiOiJuaGkgbGFtIn19LCJyb29tIjoiNmEwMzY4YjgtYzQ5YS00YmJiLWJhODMtYTY1ZDFlNWZiN2I1Iiwicm9vbU5hbWUiOiI2YTAzNjhiOC1jNDlhLTRiYmItYmE4My1hNjVkMWU1ZmI3YjUiLCJ1c2VyQ2FsbCI6eyJpZCI6IjM3MjY0ODczLTc5N2ItNDczZC1iZjRjLWZiMDE3ZmVjMDc2ZiIsImVtYWlsIjoicGhoYWkuZml0QGdtYWlsLmNvbSIsImdvb2dsZSI6IjEwMDk3MTkyMTY3NzQ1ODM5MDM3MiIsImZhY2Vib29rIjpudWxsLCJwYXNzd29yZCI6IiQyYSQxMiRqdDcyM1VqcXZxY1U2OTg5RGYzQ3NPTDY0aUZRT3BtV3V4R2NwdFU3OGJUY1E1azBqRzBtZSIsImF2YXRhciI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdncENfX2pzMURoSTl5bnNCY0syS042UGJNNDdENVowZWl2TXVfVktRPXM5Ni1jIiwibmFtZSI6IlBo4bqhbSBIYWkiLCJjb3VudHJ5IjpudWxsLCJwaG9uZSI6bnVsbCwibGFuZ3VhZ2UiOm51bGwsImJpcnRoZGF5IjpudWxsLCJyZXF1ZXN0UGFzc3dvcmQiOmZhbHNlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMS0wOC0wMVQxNzowMToyMi4yMDhaIiwidXBkYXRlZEF0IjoiMjAyMS0wOC0wMVQxNzowMToyMi4yMDhaIiwiZGVsZXRlZEF0IjpudWxsfSwidXNlckJlQ2FsbGVkIjp7ImlkIjoiODYyNDgxMzctNmY3ZC00Y2Y1LWFkMmUtMzRkYTQyNzIyYjI4IiwiZW1haWwiOiJuaGlsYW01MjkyQGdtYWlsLmNvbSIsImdvb2dsZSI6IjExNjk3Mzg1NjYzNDMzMTA2OTU1NCIsImZhY2Vib29rIjpudWxsLCJhdmF0YXIiOiJodHRwczovL2FwaS50dXRvcmluZy5sZXRzdHVkeS5pby9hdmF0YXIvODYyNDgxMzctNmY3ZC00Y2Y1LWFkMmUtMzRkYTQyNzIyYjI4YXZhdGFyMTYyODA1ODA0MjI0Ni5qcGciLCJuYW1lIjoibmhpIGxhbSIsImNvdW50cnkiOiJWTiIsInBob25lIjpudWxsLCJsYW5ndWFnZSI6bnVsbCwiYmlydGhkYXkiOiIxOTkyLTAyLTA1IiwicmVxdWVzdFBhc3N3b3JkIjpmYWxzZSwiaXNBY3RpdmF0ZWQiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjEtMDgtMDRUMDU6MjY6NDIuMzUxWiIsInVwZGF0ZWRBdCI6IjIwMjEtMDgtMDRUMDY6MjA6NDIuMzA3WiIsImRlbGV0ZWRBdCI6bnVsbH0sImlzVHV0b3IiOnRydWUsInN0YXJ0VGltZSI6IjIwMjEtMDgtMDZUMjE6MDA6MDArMDA6MDAiLCJlbmRTZXNzaW9uIjoiMjAyMS0wOC0wNlQyMTozMDowMCswMDowMCIsInRpbWVJblJvb20iOjE4MDAsImlhdCI6MTYyODI1MTk4OSwiZXhwIjoxNjI4Mjg1Mzk5LCJhdWQiOiJsaXZldHV0b3IiLCJpc3MiOiJsaXZldHV0b3IiLCJzdWIiOiJodHRwczovL21lZXQudHV0b3JpbmcubGV0c3R1ZHkuaW8ifQ.WidlN1AqoB-zo2z4LK7JY45KT11NGigR2LwNm9_H4b4",
                      studentMeetingLink:
                          "/call/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJwaGhhaS5maXRAZ21haWwuY29tIiwibmFtZSI6IlBo4bqhbSBIYWkifX0sInJvb20iOiI2YTAzNjhiOC1jNDlhLTRiYmItYmE4My1hNjVkMWU1ZmI3YjUiLCJyb29tTmFtZSI6IjZhMDM2OGI4LWM0OWEtNGJiYi1iYTgzLWE2NWQxZTVmYjdiNSIsInVzZXJDYWxsIjp7ImlkIjoiMzcyNjQ4NzMtNzk3Yi00NzNkLWJmNGMtZmIwMTdmZWMwNzZmIiwiZW1haWwiOiJwaGhhaS5maXRAZ21haWwuY29tIiwiZ29vZ2xlIjoiMTAwOTcxOTIxNjc3NDU4MzkwMzcyIiwiZmFjZWJvb2siOm51bGwsInBhc3N3b3JkIjoiJDJhJDEyJGp0NzIzVWpxdnFjVTY5ODlEZjNDc09MNjRpRlFPcG1XdXhHY3B0VTc4YlRjUTVrMGpHMG1lIiwiYXZhdGFyIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FPaDE0R2dwQ19fanMxRGhJOXluc0JjSzJLTjZQYk00N0Q1WjBlaXZNdV9WS1E9czk2LWMiLCJuYW1lIjoiUGjhuqFtIEhhaSIsImNvdW50cnkiOm51bGwsInBob25lIjpudWxsLCJsYW5ndWFnZSI6bnVsbCwiYmlydGhkYXkiOm51bGwsInJlcXVlc3RQYXNzd29yZCI6ZmFsc2UsImlzQWN0aXZhdGVkIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIxLTA4LTAxVDE3OjAxOjIyLjIwOFoiLCJ1cGRhdGVkQXQiOiIyMDIxLTA4LTAxVDE3OjAxOjIyLjIwOFoiLCJkZWxldGVkQXQiOm51bGx9LCJ1c2VyQmVDYWxsZWQiOnsiaWQiOiI4NjI0ODEzNy02ZjdkLTRjZjUtYWQyZS0zNGRhNDI3MjJiMjgiLCJlbWFpbCI6Im5oaWxhbTUyOTJAZ21haWwuY29tIiwiZ29vZ2xlIjoiMTE2OTczODU2NjM0MzMxMDY5NTU0IiwiZmFjZWJvb2siOm51bGwsImF2YXRhciI6Imh0dHBzOi8vYXBpLnR1dG9yaW5nLmxldHN0dWR5LmlvL2F2YXRhci84NjI0ODEzNy02ZjdkLTRjZjUtYWQyZS0zNGRhNDI3MjJiMjhhdmF0YXIxNjI4MDU4MDQyMjQ2LmpwZyIsIm5hbWUiOiJuaGkgbGFtIiwiY291bnRyeSI6IlZOIiwicGhvbmUiOm51bGwsImxhbmd1YWdlIjpudWxsLCJiaXJ0aGRheSI6IjE5OTItMDItMDUiLCJyZXF1ZXN0UGFzc3dvcmQiOmZhbHNlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMS0wOC0wNFQwNToyNjo0Mi4zNTFaIiwidXBkYXRlZEF0IjoiMjAyMS0wOC0wNFQwNjoyMDo0Mi4zMDdaIiwiZGVsZXRlZEF0IjpudWxsfSwiaXNUdXRvciI6ZmFsc2UsInN0YXJ0VGltZSI6IjIwMjEtMDgtMDZUMjE6MDA6MDArMDA6MDAiLCJlbmRTZXNzaW9uIjoiMjAyMS0wOC0wNlQyMTozMDowMCswMDowMCIsInRpbWVJblJvb20iOjE4MDAsImlhdCI6MTYyODI1MTk4OSwiZXhwIjoxNjI4Mjg1Mzk5LCJhdWQiOiJsaXZldHV0b3IiLCJpc3MiOiJsaXZldHV0b3IiLCJzdWIiOiJodHRwczovL21lZXQudHV0b3JpbmcubGV0c3R1ZHkuaW8ifQ.Dex0QfcSnkiAYvbYU8sfH13-Gjg0vAlCi9-aXXJDLps",
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
