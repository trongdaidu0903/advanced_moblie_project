import 'package:flutter/material.dart';
import 'package:myapp_lettutors/screens/courses/courses/views/topic_view.dart';
import 'package:myapp_lettutors/models/course/course_topic.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key? key,
    required this.index,
    required this.topic,
  }) : super(key: key);

  final int index;
  final CourseTopic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Theme.of(context).shadowColor.withOpacity(0.1),
          )
        ],
      ),
      child: ListTile(
        title: Text('${index + 1}. ${topic.name}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopicView(
                title: topic.name ?? 'null name',
                url: topic.nameFile ?? 'null file',
              ),
            ),
          );
        },
      ),
    );
  }
}
