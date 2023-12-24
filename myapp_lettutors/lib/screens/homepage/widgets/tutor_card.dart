import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp_lettutors/constants/country_list.dart';
import 'package:myapp_lettutors/constants/routes.dart';
import 'package:myapp_lettutors/models/tutor/tutor.dart';
import 'package:myapp_lettutors/models/tutor/tutor_info.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/tutor_service.dart';
import 'package:provider/provider.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({
    Key? key,
    required this.tutor,
  }) : super(key: key);

  final Tutor tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  TutorInfo? _tutorInfo;
  List<String> _specialties = [];

  void _handleTutorDetailView() {
    Navigator.pushNamed(
      context,
      Routes.teacherDetail,
      arguments: {
        'userId': widget.tutor.userId,
        'tutor': widget.tutor,
      },
    );
  }

  Future<void> _fetchTutorInfo(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;

    final learnTopics = authProvider.learnTopics
        .where((topic) =>
            _tutorInfo?.specialties?.split(',').contains(topic.key) ?? false)
        .map((e) => e.name ?? 'null');
    final testPreparations = authProvider.testPreparations
        .where((test) =>
            _tutorInfo?.specialties?.split(',').contains(test.key) ?? false)
        .map((e) => e.name ?? 'null');
    _specialties = [...learnTopics, ...testPreparations];

    final result = await TutorService.getTutorInfoById(
      token: token,
      userId: widget.tutor.userId ?? '',
    );

    if (mounted) {
      setState(() {
        _tutorInfo = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.token != null) {
      _fetchTutorInfo(authProvider);
    }

    return GestureDetector(
      onTap: () => _handleTutorDetailView(),
      child: Card(
        surfaceTintColor: Colors.lightBlueAccent,
        elevation: 3.0,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      imageUrl: widget.tutor.avatar ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.grey,
                        size: 75,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              _handleTutorDetailView();
                            },
                            child: Text(widget.tutor.name ?? 'Unknow name',
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                          ),
                          Text(
                              countryList[widget.tutor.country] ??
                                  "Unknow country",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.grey)),
                          widget.tutor.rating == null
                              ? const Text(
                                  'No reviews yet',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                )
                              : Row(
                                  children: List<Widget>.generate(
                                    widget.tutor.rating!.round(),
                                    (index) => const Icon(Icons.star,
                                        color: Colors.amber),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (authProvider.token != null) {
                        final String accessToken =
                            authProvider.token?.access?.token as String;
                        await TutorService.addTutorToFavorite(
                          token: accessToken,
                          userId: widget.tutor.userId ?? '',
                        );
                        _fetchTutorInfo(authProvider);
                      }
                    },
                    icon: _tutorInfo?.isFavorite ?? false
                        ? const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.blue,
                          ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 5,
                children: List<Widget>.generate(
                  _specialties.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Chip(
                      side: const BorderSide(color: Colors.transparent),
                      backgroundColor: Colors.white,
                      label: Text(
                        _specialties[index],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.tutor.bio ?? 'null',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _handleTutorDetailView();
                  },
                  icon: Icon(
                    Icons.bookmark_add,
                    color: Colors.cyanAccent[800],
                  ),
                  label: Text(
                    'Book',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyanAccent[800],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
