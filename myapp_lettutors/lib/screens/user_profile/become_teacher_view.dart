import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp_lettutors/providers/auth_provider.dart';
import 'package:myapp_lettutors/services/image_service.dart';
import 'package:myapp_lettutors/services/user_service.dart';
import 'package:provider/provider.dart';

class BecomeTutorRequest {
  final String name;
  final String country;
  final DateTime birthDay;
  final String interest;
  final String education;
  final String experience;
  final String profession;
  final String languages;
  final String bio;
  final String targetStudent;
  final List<String> specialties;
  final String avatar;
  final int price;
  BecomeTutorRequest(
      {required this.name,
      required this.country,
      required this.birthDay,
      required this.interest,
      required this.education,
      required this.experience,
      required this.profession,
      required this.languages,
      required this.bio,
      required this.targetStudent,
      required this.specialties,
      required this.avatar,
      required this.price});

  Future<Map<String, dynamic>> toMap() async => {
        // "avatar": await MultipartFile.fromFile(
        //   avatar,
        //   filename: avatar.split('/').last,
        //   contentType: MediaType("image", "jpeg"),
        // ),
        "name": name,
        "country": country,
        "birthday": DateFormat('yyyy-MM-dd').format(birthDay),
        "interests": interest,
        "education": education,
        "experience": experience,
        "profession": profession,
        "languages": languages,
        "bio": bio,
        // "targetStudent": targetStudent,
        // "specialties": specialties.map((e) => e).join(","),
        // "price": price,
      };
  List<MapEntry<String, String>> toDataMapFields() => [
        MapEntry("name", name),
        MapEntry("name", name),
        MapEntry("country", country),
        MapEntry("birthday", DateFormat('yyyy-MM-dd').format(birthDay)),
        MapEntry("interests", interest),
        MapEntry("education", education),
        MapEntry("experience", experience),
        MapEntry("profession", profession),
        MapEntry("languages", languages),
        MapEntry("bio", bio),
        MapEntry("targetStudent", targetStudent),
        MapEntry("specialties", specialties.map((e) => e).join(",")),
        MapEntry("price", price.toString()),
      ];

  List<MapEntry<String, MultipartFile>> toDataMapFils() => [
        MapEntry(
          "avatar",
          MultipartFile.fromFileSync(avatar, filename: avatar.split("/").last),
        ),
      ];
}

class BecomeTeacherView extends StatefulWidget {
  const BecomeTeacherView({Key? key}) : super(key: key);

  @override
  State<BecomeTeacherView> createState() => _BecomeTeacherViewState();
}

class _BecomeTeacherViewState extends State<BecomeTeacherView> {
  BothImageData? image;
  BothImageData? video;

  final TextEditingController _nameController =
      TextEditingController(text: "Pham Hai");
  final TextEditingController _fromController =
      TextEditingController(text: "Vietnam");
  final TextEditingController _dobController =
      TextEditingController(text: "1999-01-01");
  final TextEditingController _interestController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");
  final TextEditingController _educationController =
      TextEditingController(text: "HCM University of Science");
  final TextEditingController _experienceController =
      TextEditingController(text: "I have worked for 2 years in a company");
  final TextEditingController _professionController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");
  final TextEditingController _certificateController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");
  final TextEditingController _languageController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");
  final TextEditingController _introductionController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");
  final TextEditingController _bestAtController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");
  final TextEditingController _specialtiesController = TextEditingController(
      text: "I love teaching, I love teaching, I love teaching");

  @override
  void dispose() {
    _nameController.dispose();
    _fromController.dispose();
    _dobController.dispose();
    _interestController.dispose();
    _educationController.dispose();
    _experienceController.dispose();
    _professionController.dispose();
    _certificateController.dispose();
    _languageController.dispose();
    _introductionController.dispose();
    _bestAtController.dispose();
    _specialtiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          "Become a tutor",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: const [SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Basic Info',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Column(
                  children: [
                    if (image == null)
                      Image.asset(
                        'assets/user/user-avatar-01.png',
                        width: 100,
                        height: 100,
                      )
                    else if (image!.image != null)
                      Image.memory(
                        image!.image!,
                        width: 100,
                        height: 100,
                      ),
                    TextButton(
                      onPressed: () async {
                        await ImagePicService.selectedImage(ImageSource.gallery)
                            .then((value) {
                          setState(() {
                            image = value;
                          });
                        });
                      },
                      child: const Text('Upload'),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tutoring Name',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 2),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'I am from',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 2),
                      TextField(
                        controller: _fromController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date of Birth',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 2),
                      // SelectDate(
                      //   initialValue: '',
                      //   onChanged: (newValue) {},
                      // ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'CV',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Interests',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _interestController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Education',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _educationController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Experience',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _experienceController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current or Previous Profession',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _professionController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Certificate',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Add New Certificate'),
            ),
            const SizedBox(height: 16),
            Text(
              'Languages I speak',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Languages',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _languageController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Who I teach',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Introduction',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _introductionController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'I am best at teaching students who are',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _bestAtController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'My specialties are',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _specialtiesController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Introduction Video',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextButton(
                onPressed: () async {
                  await ImagePicService.selectedImage(ImageSource.gallery)
                      .then((value) {
                    setState(() {
                      video = value;
                    });
                  });
                },
                child: const Text('Choose Video'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Colors.blue),
                onPressed: () async {
                  final response = await UserService.becomeTutor(
                    BecomeTutorRequest(
                      name: _nameController.text,
                      country: _fromController.text,
                      birthDay: DateTime.now(),
                      interest: _interestController.text,
                      education: _educationController.text,
                      experience: _experienceController.text,
                      profession: _professionController.text,
                      languages: _languageController.text,
                      bio: _certificateController.text,
                      targetStudent: _bestAtController.text,
                      specialties: ["ielts", "toeic"],
                      avatar: image!.path ?? "",
                      price: 2000,
                    ),
                    token: context.read<AuthProvider>().token?.access?.token,
                  );
                  final snackBar = SnackBar(
                    content: Text(
                      response ?? "",
                      style: const TextStyle().copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    backgroundColor: Colors.black,
                  );

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
