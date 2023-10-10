import 'package:flutter/material.dart';
import 'package:myapp_lettutors/constants/routes.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/screens/courses/courses_page.dart';
import 'package:myapp_lettutors/screens/homepage/homepage.dart';
import 'package:myapp_lettutors/screens/schedule/schedule_page.dart';
import 'package:myapp_lettutors/screens/setting/setting_page.dart';
import 'package:myapp_lettutors/screens/tutors_search/tutors_search.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> pages = [
    const HomePage(),
    const TutorSearchPage(),
    const SchedulePage(),
    const CoursesPage(),
    const SettingsPage(),
  ];
  List<String> pagesTitles = [
    'Home',
    'Tutors',
    'Schedule',
    'Courses',
    'Settings'
  ];
  int _chosenPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/logo/lettutor.png',
              width: 50,
              height: 50,
            ),
            Text(
              pagesTitles[_chosenPageIndex],
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        actions: _chosenPageIndex == 0
            ? [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.userProfile);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        authProvider.currentUser.avatar ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person_rounded),
                      ),
                    ),
                  ),
                )
              ]
            : [],
      ),
      body: pages[_chosenPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _chosenPageIndex = value;
          });
        },
        elevation: 20,
        currentIndex: _chosenPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tutors'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
