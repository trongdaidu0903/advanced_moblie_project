import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/schedule/booking_info.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/user_service.dart';
import 'package:provider/provider.dart';

import '../widgets/history_card.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<BookingInfo> historyClasses = [];

  int _page = 1;
  final int _perPage = 5;
  int _count = 0;
  bool _isLoading = true;

  Future<void> _fetchHistory(String token) async {
    final result = await UserService.getHistory(
      token: token,
      page: _page,
      perPage: _perPage,
    );

    setState(() {
      historyClasses = result['classes'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchHistory(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : historyClasses.isEmpty
            ? const Center(
                child: Text('You have not booked any class'),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ...List<Widget>.generate(
                      historyClasses.length,
                      (index) =>
                          HistoryCard(bookingInfo: historyClasses[index]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor:
                                _page == 1 ? Colors.grey : Colors.blue[300],
                          ),
                          onPressed: _page == 1
                              ? null
                              : () {
                                  setState(() {
                                    _isLoading = true;
                                    _page--;
                                  });
                                },
                          icon: const Icon(
                            Icons.navigate_before_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Page $_page/${(_count / _perPage).ceil()}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: _page == _count
                                ? Colors.grey
                                : Colors.blue[300],
                          ),
                          onPressed: _page == (_count / _perPage).ceil()
                              ? null
                              : () {
                                  setState(() {
                                    _isLoading = true;
                                    _page++;
                                  });
                                },
                          icon: const Icon(
                            Icons.navigate_next_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
  }
}
