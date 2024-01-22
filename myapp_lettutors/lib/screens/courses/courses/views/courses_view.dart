import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/course/course.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/course_service.dart';
import 'package:provider/provider.dart';

import '../widgets/course_card.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  final _searchController = TextEditingController();
  List<Course> courses = [];

  int _page = 1;
  final int _perPage = 5;
  int _count = 0;
  bool _isLoading = true;

  Future<void> _fetchCourses(String token, String search) async {
    final result = await CourseService.getListCourseWithPagination(
      page: _page,
      size: _perPage,
      token: token,
      search: search,
    );

    setState(() {
      courses = result['courses'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  Future<void> _searchCourses(String token, String search) async {
    final result = await CourseService.searchCourse(
      token: token,
      search: search,
      page: _page,
      size: _perPage,
    );

    setState(() {
      courses = result['courses'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchCourses(accessToken, _searchController.text);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onSubmitted: (value) {
              final String accessToken =
                  authProvider.token?.access?.token as String;
              _searchCourses(accessToken, value);
              setState(() {
                _isLoading = true;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 24),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: 'search',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : courses.isEmpty
                    ? _searchController.text.isEmpty
                        ? const Center(
                            child: Text(
                              'There is no course available',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'No result(s) matches your search',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List<Widget>.generate(
                              courses.length,
                              (index) => CourseCard(course: courses[index]),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: _page == 1
                                        ? Colors.grey
                                        : Colors.blue[300],
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
                      ),
          )
        ],
      ),
    );
  }
}
