import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:myapp_lettutors/constants/country_list.dart';
import 'package:myapp_lettutors/constants/language_list.dart';
import 'package:myapp_lettutors/constants/routes.dart';
import 'package:myapp_lettutors/models/tutor/tutor_feedback.dart';
import 'package:myapp_lettutors/models/tutor/tutor_info.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/screens/booking/widgets/tutor_schedule.dart';
import 'package:myapp_lettutors/screens/tutor/tutor_detail/tutor_report_dialog.dart';
import 'package:myapp_lettutors/services/tutor_service.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TutorDetailView extends StatefulWidget {
  const TutorDetailView({Key? key}) : super(key: key);

  @override
  State<TutorDetailView> createState() => _TutorDetailViewState();
}

class _TutorDetailViewState extends State<TutorDetailView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  late TutorInfo _tutorInfo;
  late final List<String> _specialties;
  late final List<String> languages;
  List<TutorFeedback>? feedbacks;
  late String userId;

  bool _isLoading = true;

  Future<void> _fetchTutorInfo(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;

    final result = await TutorService.getTutorInfoById(
      token: token,
      userId: userId,
    );

    if (_isLoading) {
      final learnTopics = authProvider.learnTopics
          .where((topic) =>
              result.specialties?.split(',').contains(topic.key) ?? false)
          .map((e) => e.name ?? 'null');
      final testPreparations = authProvider.testPreparations
          .where((test) =>
              result.specialties?.split(',').contains(test.key) ?? false)
          .map((e) => e.name ?? 'null');
      _specialties = [...learnTopics, ...testPreparations];
      languages = result.languages?.split(',') ?? ['null'];
    }

    if (mounted) {
      setState(() {
        _tutorInfo = result;
        _isLoading = false;
        _videoPlayerController =
            // ignore: deprecated_member_use
            VideoPlayerController.network(_tutorInfo.video ?? '');
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          aspectRatio: 2 / 3,
          autoPlay: true,
        );
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final data = ModalRoute.of(context)?.settings.arguments as Map;
      userId = data['userId'];
      feedbacks = data['tutor'].feedbacks;

      _fetchTutorInfo(authProvider);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Tutorial Details',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: _chewieController == null
                        ? Text(
                            'No Introduction Video',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[700],
                            ),
                          )
                        : Chewie(controller: _chewieController!),
                  ),

                  Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _tutorInfo.user?.avatar ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 72,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _tutorInfo.user?.name ?? 'null name',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              countryList[_tutorInfo.user?.country] ??
                                  'unknown country',
                              style: const TextStyle(fontSize: 16),
                            ),
                            _tutorInfo.rating == null
                                ? const Text(
                                    'No reviews yet',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Row(children: [
                                    ...List<Widget>.generate(
                                      _tutorInfo.rating?.round() ?? 0,
                                      (index) => const Icon(Icons.star,
                                          color: Colors.amber),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('(${_tutorInfo.totalFeedback})',
                                        style: const TextStyle(fontSize: 18))
                                  ])
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      _tutorInfo.bio ?? 'null bio',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text('Languages',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 5,
                      children: List<Widget>.generate(
                        languages.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            side: const BorderSide(color: Colors.transparent),
                            label: Text(
                              languageList[languages[index]]?['name'] ??
                                  'unknown language',
                              style: const TextStyle(color: Colors.blue),
                            ),
                            backgroundColor: Colors.blue[50],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Specialties',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 5,
                      children: List<Widget>.generate(
                        _specialties.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            side: const BorderSide(color: Colors.transparent),
                            backgroundColor: Colors.lightBlue[50],
                            label: Text(
                              _specialties[index],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text('Suggested Courses', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                  // ...courses.map((course) => Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12),
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             course.name,
                  //             style: Theme.of(context).textTheme.headlineMedium,
                  //           ),s
                  //           const SizedBox(width: 16),
                  //           TextButton(
                  //               onPressed: () {
                  //                 Navigator.pushNamed(context, Routes.courseDetail);
                  //               },
                  //               child: const Text('View'))
                  //         ],
                  //       ),
                  //     )),
                  const SizedBox(height: 12),
                  Text('Interests',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text(_tutorInfo.interests ?? 'No interests'),
                  ),
                  const SizedBox(height: 12),
                  Text('Teaching Experiences',
                      style: Theme.of(context).textTheme.displaySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text(
                        _tutorInfo.experience ?? 'No teaching experiences'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            if (authProvider.token != null) {
                              final String accessToken =
                                  authProvider.token?.access?.token as String;
                              await TutorService.addTutorToFavorite(
                                token: accessToken,
                                userId: userId,
                              );
                              _fetchTutorInfo(authProvider);
                            }
                          },
                          child: Column(
                            children: [
                              _tutorInfo.isFavorite!
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.blue,
                                    ),
                              Text(
                                'Favorite',
                                style: TextStyle(
                                  color: _tutorInfo.isFavorite!
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.review,
                              arguments: feedbacks,
                            );
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.reviews_outlined, color: Colors.blue),
                              Text('Reviews',
                                  style: TextStyle(color: Colors.blue))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            // await _showReportDialog(context);
                            final result = await showDialog(
                              context: context,
                              builder: (context) => TutorReportDialog(
                                token: authProvider.token?.access?.token ?? '',
                                userId: userId,
                              ),
                            );
                            if (result) {
                              // ignore: use_build_context_synchronously
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Report Success'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK')),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.report_outlined, color: Colors.blue),
                              Text('Report',
                                  style: TextStyle(color: Colors.blue))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size.fromHeight(0),
                              padding: const EdgeInsets.all(8),
                              side:
                                  const BorderSide(color: Colors.transparent)),
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              elevation: 5,
                              clipBehavior: Clip.hardEdge,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (context) =>
                                  TutorSchedule(userId: userId),
                            );
                          },
                          child: const Text(
                            'Book This Tutor',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
