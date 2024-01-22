import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/tutor/tutor.dart';
import 'package:myapp_lettutors/services/tutor_service.dart';

import '../widgets/tutor_search_card.dart';

class TutorSearchResult extends StatefulWidget {
  const TutorSearchResult({Key? key}) : super(key: key);

  @override
  State<TutorSearchResult> createState() => _TutorSearchResultState();
}

class _TutorSearchResultState extends State<TutorSearchResult> {
  int _page = 1;
  final int _perPage = 5;
  bool _isLoading = true;
  List<Tutor> _tutors = [];
  int _count = 0;

  Future<void> _searchTutors(
    String accessToken,
    String name,
    bool isVietnamese,
    List<String> specialties,
  ) async {
    final result = await TutorService.searchTutor(
      token: accessToken,
      search: name,
      page: _page,
      perPage: _perPage,
      nationality: {'isVietNamese': isVietnamese},
      specialties: specialties,
    );

    setState(() {
      _count = result['count'];
      _tutors = result['tutors'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    if (_isLoading) {
      _searchTutors(
        data['token'],
        data['search'],
        data['nationality'],
        data['specialties'],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          "Search Result",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: const [SizedBox(width: 16)],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tutors.isEmpty
                        ? 'No Matches Found'
                        : 'Found $_count result(s)',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  ...List<Widget>.generate(
                    _tutors.length,
                    (index) => TutorSearchCard(tutor: _tutors[index]),
                  ),
                  _count > 0
                      ? Row(
                          children: [
                            const SizedBox(width: 16),
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
                            const SizedBox(width: 16),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }
}
