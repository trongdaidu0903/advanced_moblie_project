import 'package:flutter/material.dart';

class TutorFeedbackView extends StatefulWidget {
  const TutorFeedbackView({Key? key}) : super(key: key);

  @override
  State<TutorFeedbackView> createState() => _TutorFeedbackViewState();
}

class _TutorFeedbackViewState extends State<TutorFeedbackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Reviews',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
