import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/tutor/tutor_feedback.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class TutorFeedbackView extends StatefulWidget {
  const TutorFeedbackView({Key? key}) : super(key: key);

  @override
  State<TutorFeedbackView> createState() => _TutorFeedbackViewState();
}

class _TutorFeedbackViewState extends State<TutorFeedbackView> {
  @override
  Widget build(BuildContext context) {
    late List<TutorFeedback> tutorFeedbacks;
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.token != null) {
      tutorFeedbacks =
          ModalRoute.of(context)!.settings.arguments as List<TutorFeedback>;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          "Tutor Reviews",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tutorFeedbacks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(
                        'No name',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      subtitle: Text(
                        tutorFeedbacks[index].content ?? 'No feedback',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      trailing: Text(
                        tutorFeedbacks[index].rating.toString(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
