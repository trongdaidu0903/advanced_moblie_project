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
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(tutorFeedbacks[index]
                                .firstInfo
                                ?.avatar ??
                            'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg'),
                        radius: 30,
                      ),
                      title: Text(
                        tutorFeedbacks[index].firstInfo?.name ?? 'Annymous',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                        tutorFeedbacks[index].content ?? 'No feedback',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: tutorFeedbacks[index].rating,
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          );
                        },
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
