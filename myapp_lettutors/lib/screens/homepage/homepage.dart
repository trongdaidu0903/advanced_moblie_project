import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/tutor/tutor.dart';
import 'package:myapp_lettutors/models/tutor/tutor_info.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/screens/homepage/widgets/homepage_header.dart';
import 'package:myapp_lettutors/screens/homepage/widgets/tutor_card.dart';
import 'package:myapp_lettutors/services/tutor_service.dart';
import 'package:myapp_lettutors/services/user_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthProvider get _auth => context.read<AuthProvider>();

  List<Tutor> _tutors = [];
  final List<TutorInfo> _infos = [];
  bool _isLoading = true;

  Future<void> _fetchRecommendedTutors(AuthProvider authProvider) async {
    final String? token = authProvider.token?.access?.token;
    if (token?.isNotEmpty ?? false) {
      final topics = await UserService.getLearningTopic(token!);
      final tests = await UserService.getTestPreparation(token);
      authProvider.setLearnTopic(topics);
      authProvider.setTestPreparation(tests);

      _tutors = await TutorService.getListTutorWithPagination(
        page: 1,
        perPage: 10,
        token: token,
      );

      _tutors.sort((a, b) {
        if (a.rating == null || b.rating == null) return 0;
        return a.rating!.compareTo(b.rating!);
      });

      for (var tutor in _tutors) {
        final info = await TutorService.getTutorInfoById(
          token: token,
          userId: tutor.userId!,
        );
        _infos.add(info);
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _fetchRecommendedTutors(_auth);
    ThemeData.dark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomepageHeader(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Recommended Tutors',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tutors.length,
                  itemBuilder: (context, index) {
                    return TutorCard(tutor: _tutors[index]);
                  },
                )
        ],
      ),
    );
  }
}
