import 'package:flutter/material.dart';
import 'package:myapp_lettutors/screens/courses/courses/views/courses_view.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: CoursesView(),
        )
      ],
    );
  }
}
