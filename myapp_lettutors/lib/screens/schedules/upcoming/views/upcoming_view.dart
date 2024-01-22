import 'package:flutter/material.dart';
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
  List<BookingInfo> upcomingClasses = [];

  final int _page = 1;
  final int _perPage = 5;
  bool _isLoading = true;

  Future<void> _fetchUpcomingClasses(String token) async {
    final result = await UserService.getAllUpcomingClasses(
      token: token,
      page: _page,
      perPage: _perPage,
    );

    setState(() {
      upcomingClasses = result['classes'];
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
                ...List<Widget>.generate(
                    upcomingClasses.length,
                    (index) => UpcomingClassCard(
                          bookingInfo: upcomingClasses[index],
                          onCancel: (value) {
                            if (value) {
                              setState(() {
                                _isLoading = true;
                              });
                            }
                          },
                        )).toList(),
                const SizedBox(height: 8),
              ],
            ),
          );
  }
}
