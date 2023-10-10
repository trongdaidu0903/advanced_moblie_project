import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp_lettutors/providers/app_provider.dart';
import 'package:myapp_lettutors/screens/authentication/login_screen.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const LetTutor());
}

class LetTutor extends StatelessWidget {
  const LetTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => AuthProvider(),
        // ),
      ],
      child: MaterialApp(
          title: 'LetTutor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                  letterSpacing: 1.1),
              headline2: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                //letterSpacing: 1.0,
                color: Colors.blue[600],
              ),
              headline3: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              headline4: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              bodyText1:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              bodyText2: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
            ),
          ),
          home: const LoginView(),
          routes: const {
            // Routes.login: (context) => const LoginView(),
            // Routes.register: (context) => const RegisterView(),
            // Routes.forgotPassword: (context) => const ForgotPasswordView(),
            // Routes.main: (context) => const NavigationPage(),
            // Routes.becomeTutor: (context) => const BecomeTutorView(),
            // Routes.userProfile: (context) => const UserProfileView(),
            // Routes.courseDetail: (context) => const CourseDetailView(),
            // Routes.teacherDetail: (context) => const TutorDetailView(),
            // Routes.review: (context) => const TutorFeedbackView(),
            // Routes.writeReview: (context) => const WriteReviewView(),
            // Routes.tutorSearchResult: (context) => const TutorSearchResult(),
          }),
    );
  }
}
