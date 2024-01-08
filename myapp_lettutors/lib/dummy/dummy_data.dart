// import 'package:intl/intl.dart';
// import 'package:myapp_lettutors/dummy/ebook.dart';
// import 'package:myapp_lettutors/dummy/review.dart';
// import 'package:myapp_lettutors/dummy/teacher.dart';
// import 'package:myapp_lettutors/models/schedule/booking_info.dart';

// const nationalities = [
//   'Foreign Tutor',
//   'Native English Tutor',
//   'Vietnamese Tutor',
// ];

// const levels = [
//   'Pre A1 (Beginner)',
//   'A1 (Higher Beginner)',
//   'A2 (Pre-Intermediate)',
//   'B1 (Intermediate)',
//   'B2 (Upper-Intermediate)',
//   'C1 (Advanced)',
//   'C2 (Proficiency)',
// ];

// const learnTopics = [
//   'English for kids',
//   'English for Business',
//   'Conversational',
// ];

// const testPreparations = [
//   'STARTERS',
//   'MOVERS',
//   'FLYERS',
//   'KET',
//   'PET',
//   'IELTS',
//   'TOEFL',
//   'TOEIC'
// ];

// const specialties = [
//   'All',
//   'English for kids',
//   'English for Business',
//   'Conversational',
//   'STARTERS',
//   'MOVERS',
//   'FLYERS',
//   'KET',
//   'PET',
//   'IELTS',
//   'TOEFL',
//   'TOEIC'
// ];

// var upcomingTutor = BookingInfo(
//   createdAtTimeStamp: DateTime.now().millisecondsSinceEpoch,
//   updatedAtTimeStamp: DateTime.now().millisecondsSinceEpoch,
//   id: "22f9e210-a712-43f8-b73c-8a036583c0ec",
//   userId: "37264873-797b-473d-bf4c-fb017fec076f",
//   scheduleDetailId: "022d0e8d-5957-4dd9-8a2e-862d34f7e0c9",
//   tutorMeetingLink:
//       "/call/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJuaGlsYW01MjkyQGdtYWlsLmNvbSIsIm5hbWUiOiJuaGkgbGFtIn19LCJyb29tIjoiNmEwMzY4YjgtYzQ5YS00YmJiLWJhODMtYTY1ZDFlNWZiN2I1Iiwicm9vbU5hbWUiOiI2YTAzNjhiOC1jNDlhLTRiYmItYmE4My1hNjVkMWU1ZmI3YjUiLCJ1c2VyQ2FsbCI6eyJpZCI6IjM3MjY0ODczLTc5N2ItNDczZC1iZjRjLWZiMDE3ZmVjMDc2ZiIsImVtYWlsIjoicGhoYWkuZml0QGdtYWlsLmNvbSIsImdvb2dsZSI6IjEwMDk3MTkyMTY3NzQ1ODM5MDM3MiIsImZhY2Vib29rIjpudWxsLCJwYXNzd29yZCI6IiQyYSQxMiRqdDcyM1VqcXZxY1U2OTg5RGYzQ3NPTDY0aUZRT3BtV3V4R2NwdFU3OGJUY1E1azBqRzBtZSIsImF2YXRhciI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdncENfX2pzMURoSTl5bnNCY0syS042UGJNNDdENVowZWl2TXVfVktRPXM5Ni1jIiwibmFtZSI6IlBo4bqhbSBIYWkiLCJjb3VudHJ5IjpudWxsLCJwaG9uZSI6bnVsbCwibGFuZ3VhZ2UiOm51bGwsImJpcnRoZGF5IjpudWxsLCJyZXF1ZXN0UGFzc3dvcmQiOmZhbHNlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMS0wOC0wMVQxNzowMToyMi4yMDhaIiwidXBkYXRlZEF0IjoiMjAyMS0wOC0wMVQxNzowMToyMi4yMDhaIiwiZGVsZXRlZEF0IjpudWxsfSwidXNlckJlQ2FsbGVkIjp7ImlkIjoiODYyNDgxMzctNmY3ZC00Y2Y1LWFkMmUtMzRkYTQyNzIyYjI4IiwiZW1haWwiOiJuaGlsYW01MjkyQGdtYWlsLmNvbSIsImdvb2dsZSI6IjExNjk3Mzg1NjYzNDMzMTA2OTU1NCIsImZhY2Vib29rIjpudWxsLCJhdmF0YXIiOiJodHRwczovL2FwaS50dXRvcmluZy5sZXRzdHVkeS5pby9hdmF0YXIvODYyNDgxMzctNmY3ZC00Y2Y1LWFkMmUtMzRkYTQyNzIyYjI4YXZhdGFyMTYyODA1ODA0MjI0Ni5qcGciLCJuYW1lIjoibmhpIGxhbSIsImNvdW50cnkiOiJWTiIsInBob25lIjpudWxsLCJsYW5ndWFnZSI6bnVsbCwiYmlydGhkYXkiOiIxOTkyLTAyLTA1IiwicmVxdWVzdFBhc3N3b3JkIjpmYWxzZSwiaXNBY3RpdmF0ZWQiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjEtMDgtMDRUMDU6MjY6NDIuMzUxWiIsInVwZGF0ZWRBdCI6IjIwMjEtMDgtMDRUMDY6MjA6NDIuMzA3WiIsImRlbGV0ZWRBdCI6bnVsbH0sImlzVHV0b3IiOnRydWUsInN0YXJ0VGltZSI6IjIwMjEtMDgtMDZUMjE6MDA6MDArMDA6MDAiLCJlbmRTZXNzaW9uIjoiMjAyMS0wOC0wNlQyMTozMDowMCswMDowMCIsInRpbWVJblJvb20iOjE4MDAsImlhdCI6MTYyODI1MTk4OSwiZXhwIjoxNjI4Mjg1Mzk5LCJhdWQiOiJsaXZldHV0b3IiLCJpc3MiOiJsaXZldHV0b3IiLCJzdWIiOiJodHRwczovL21lZXQudHV0b3JpbmcubGV0c3R1ZHkuaW8ifQ.WidlN1AqoB-zo2z4LK7JY45KT11NGigR2LwNm9_H4b4",
//   studentMeetingLink:
//       "/call/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJwaGhhaS5maXRAZ21haWwuY29tIiwibmFtZSI6IlBo4bqhbSBIYWkifX0sInJvb20iOiI2YTAzNjhiOC1jNDlhLTRiYmItYmE4My1hNjVkMWU1ZmI3YjUiLCJyb29tTmFtZSI6IjZhMDM2OGI4LWM0OWEtNGJiYi1iYTgzLWE2NWQxZTVmYjdiNSIsInVzZXJDYWxsIjp7ImlkIjoiMzcyNjQ4NzMtNzk3Yi00NzNkLWJmNGMtZmIwMTdmZWMwNzZmIiwiZW1haWwiOiJwaGhhaS5maXRAZ21haWwuY29tIiwiZ29vZ2xlIjoiMTAwOTcxOTIxNjc3NDU4MzkwMzcyIiwiZmFjZWJvb2siOm51bGwsInBhc3N3b3JkIjoiJDJhJDEyJGp0NzIzVWpxdnFjVTY5ODlEZjNDc09MNjRpRlFPcG1XdXhHY3B0VTc4YlRjUTVrMGpHMG1lIiwiYXZhdGFyIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FPaDE0R2dwQ19fanMxRGhJOXluc0JjSzJLTjZQYk00N0Q1WjBlaXZNdV9WS1E9czk2LWMiLCJuYW1lIjoiUGjhuqFtIEhhaSIsImNvdW50cnkiOm51bGwsInBob25lIjpudWxsLCJsYW5ndWFnZSI6bnVsbCwiYmlydGhkYXkiOm51bGwsInJlcXVlc3RQYXNzd29yZCI6ZmFsc2UsImlzQWN0aXZhdGVkIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIxLTA4LTAxVDE3OjAxOjIyLjIwOFoiLCJ1cGRhdGVkQXQiOiIyMDIxLTA4LTAxVDE3OjAxOjIyLjIwOFoiLCJkZWxldGVkQXQiOm51bGx9LCJ1c2VyQmVDYWxsZWQiOnsiaWQiOiI4NjI0ODEzNy02ZjdkLTRjZjUtYWQyZS0zNGRhNDI3MjJiMjgiLCJlbWFpbCI6Im5oaWxhbTUyOTJAZ21haWwuY29tIiwiZ29vZ2xlIjoiMTE2OTczODU2NjM0MzMxMDY5NTU0IiwiZmFjZWJvb2siOm51bGwsImF2YXRhciI6Imh0dHBzOi8vYXBpLnR1dG9yaW5nLmxldHN0dWR5LmlvL2F2YXRhci84NjI0ODEzNy02ZjdkLTRjZjUtYWQyZS0zNGRhNDI3MjJiMjhhdmF0YXIxNjI4MDU4MDQyMjQ2LmpwZyIsIm5hbWUiOiJuaGkgbGFtIiwiY291bnRyeSI6IlZOIiwicGhvbmUiOm51bGwsImxhbmd1YWdlIjpudWxsLCJiaXJ0aGRheSI6IjE5OTItMDItMDUiLCJyZXF1ZXN0UGFzc3dvcmQiOmZhbHNlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMS0wOC0wNFQwNToyNjo0Mi4zNTFaIiwidXBkYXRlZEF0IjoiMjAyMS0wOC0wNFQwNjoyMDo0Mi4zMDdaIiwiZGVsZXRlZEF0IjpudWxsfSwiaXNUdXRvciI6ZmFsc2UsInN0YXJ0VGltZSI6IjIwMjEtMDgtMDZUMjE6MDA6MDArMDA6MDAiLCJlbmRTZXNzaW9uIjoiMjAyMS0wOC0wNlQyMTozMDowMCswMDowMCIsInRpbWVJblJvb20iOjE4MDAsImlhdCI6MTYyODI1MTk4OSwiZXhwIjoxNjI4Mjg1Mzk5LCJhdWQiOiJsaXZldHV0b3IiLCJpc3MiOiJsaXZldHV0b3IiLCJzdWIiOiJodHRwczovL21lZXQudHV0b3JpbmcubGV0c3R1ZHkuaW8ifQ.Dex0QfcSnkiAYvbYU8sfH13-Gjg0vAlCi9-aXXJDLps",
//   studentRequest: "Request from student",
//   tutorReview: "Tutor review",
//   scoreByTutor: 3,
//   createdAt: DateFormat().add_yMEd().format(DateTime.now()),
//   updatedAt: DateFormat().add_yMEd().format(DateTime.now()),
//   recordUrl: "",
//   isDeleted: false,
//   scheduleDetailInfo: null,
//   classReview: null,
// );

// const teachers = [
//   Teacher(
//       'Keegan',
//       'assets/tutor/keegan-avatar.png',
//       'France',
//       5,
//       60,
//       'I am passionate about running and fitness, '
//           'I often compete in trail/mountain running events and I love pushing myself. '
//           'I am training to one day take part in ultra-endurance events. '
//           'I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. '
//           'My most memorable life experience would be living in and traveling around Southeast Asia.',
//       [
//         'English for kids',
//         'English for Business',
//         'Conversational',
//         'IELTS',
//         'TOEFL',
//         'TOEIC'
//       ]),
//   Teacher(
//       'Jill Leano',
//       'assets/tutor/jill-leano-avatar.png',
//       'France',
//       4,
//       9,
//       "Hi, My name is Jill I am an experienced English Teacher from Philippine. "
//           "I would like to share my enthusiasm with the learners in this platform. "
//           "I've been working with diverse learners of all levels for many years. "
//           "I am greatly passionate about about profession. I love teaching "
//           "because I can help others improve their skills and it gives me joy and "
//           "excitement meeting different learners around the world. "
//           "In my class I worked with wonderful enthusiasm and positivity, "
//           "and I'm happy to focus on my learner's goal.",
//       [
//         'English for kids',
//         'English for Business',
//         'Conversational',
//         'IELTS',
//         'TOEFL',
//         'TOEIC'
//       ]),
//   Teacher(
//       'April Baldo',
//       'assets/tutor/april-baldo-avatar.png',
//       'Philippine',
//       4,
//       22,
//       "Hello! My name is April Baldo, you can just call me Teacher April. "
//           "I am an English teacher and currently teaching in senior high school. "
//           "I have been teaching grammar and literature for almost 10 years. "
//           "I am fond of reading and teaching literature as one way of knowing one’s "
//           "beliefs and culture. I am friendly and full of positivity. "
//           "I love teaching because I know each student has something to bring on. "
//           "Molding them to become an individual is a great success.",
//       [
//         'English for Business',
//         'KET',
//         'PET',
//         'IELTS',
//       ]),
//   Teacher(
//       'Joan Gacer',
//       'assets/tutor/joan-gacer-avatar.png',
//       'Taiwan',
//       3,
//       6,
//       "I was a customer service sales executive for 3 years before I become an ESL teacher "
//           "I am trained to deliver excellent service to my clients so I can help you with "
//           "business English dealing with customers or in sales-related jobs and a lot more, "
//           "I also love to teach beginner, intermediate and advance I speak slowly and "
//           "clearly so that the student can easily follow my instructions and pronunciation. "
//           "In my class, I want environment-friendly fun and engaging I have many activities "
//           "designed to help your enthusiasm in learning the language. I'm so excited to "
//           "meet you in one of my classes let us have fun while learning English. See you there.",
//       [
//         'English for kids',
//         'English for Business',
//         'Conversational',
//         'STARTERS',
//         'MOVERS',
//         'FLYERS',
//         'KET',
//         'PET',
//         'IELTS',
//         'TOEFL',
//         'TOEIC'
//       ]),
// ];

// // const dummyCourses = [
// //   Course(
// //     'Life in the Internet Age',
// //     'assets/course/course-01.png',
// //     "Let's discuss how technology is changing the way we live",
// //     'Intermediate',
// //     9,
// //   ),
// //   Course(
// //     'Caring for Our Planet',
// //     'assets/course/course-02.png',
// //     "Let's discuss our relationship as humans with our planet, Earth",
// //     'Intermediate',
// //     7,
// //   ),
// //   Course(
// //     'Healthy Mind, Healthy Body',
// //     'assets/course/course-03.png',
// //     "Let's discuss the many aspects of living a long, happy life",
// //     'Intermediate',
// //     6,
// //   ),
// //   Course(
// //     'Movies and Television',
// //     'assets/course/course-04.png',
// //     "Let's discuss our preferences and habits surrounding movies and television shows",
// //     'Beginner',
// //     10,
// //   ),
// //   Course(
// //     'Raising Children',
// //     'assets/course/course-05.png',
// //     "Let's discuss raising children and practice using English for common parenting situations",
// //     'Intermediate',
// //     11,
// //   ),
// //   Course(
// //     'The Olympics',
// //     'assets/course/course-06.png',
// //     "Let’s practice talking about the Olympics, the biggest sports festival on earth!",
// //     'Advanced',
// //     8,
// //   ),
// // ];

// const courseTopics = [
//   'The Internet',
//   'Artificial Intelligence (AI)',
//   'Social Media',
//   'Internet Privacy',
//   'Live Streaming',
//   'Coding',
//   'Technology Transforming Healthcare',
//   'Smart Home Technology',
//   'Remote Work - A Dream Job?',
// ];

// const ebooks = [
//   EBook(
//       'Family and Friends 1',
//       "For kids who can read pretty well, get ready for compound sentences and...",
//       'Upper-Beginner',
//       'assets/ebook/family-and-friends.jpg'),
//   EBook(
//       'Family and Friends 2',
//       "For kids who can read pretty well, get ready for compound sentences and...",
//       'Upper-Beginner',
//       'assets/ebook/family-and-friends.jpg'),
//   EBook(
//       'Family and Friends 3',
//       "For kids who can read pretty well, get ready for compound sentences and...",
//       'Upper-Beginner',
//       'assets/ebook/family-and-friends.jpg'),
//   EBook(
//       'Everybody Up',
//       "For: kids who want to learn English through pictures, pick up simple...",
//       'Beginner',
//       'assets/everybody-up.jpg'),
//   EBook(
//       'Cambridge Storyfun For Starter',
//       "For kids who can handle single words and simple sentences with assistance.",
//       'Beginner',
//       'assets/ebook/storyfun.jpg'),
//   EBook(
//       'New Headway Elementary',
//       "For teenagers who want to form a grammatical background as well as...",
//       'Beginner',
//       'assets/ebook/new-headway.jpg'),
//   EBook(
//       'English World ',
//       "For kids who are able to pick up simple sounds, letters, words and learn new...",
//       'Beginner',
//       'assets/ebook/english-world.jpg'),
// ];

// const courseHours = [
//   '00:00 - 00:25',
//   '00:30 - 00:55',
//   '01:00 - 01:25',
//   '01:30 - 01:55',
//   '02:00 - 02:25',
//   '02:30 - 02:55',
//   '03:00 - 03:25',
//   '03:30 - 03:55',
//   '04:00 - 04:25',
//   '04:30 - 04:55',
//   '05:00 - 05:25',
//   '05:30 - 05:55',
//   '06:00 - 06:25',
//   '06:30 - 06:55',
//   '07:00 - 07:25',
//   '07:30 - 07:55',
//   '08:00 - 08:25',
//   '08:30 - 08:55',
//   '09:00 - 09:25',
//   '09:30 - 09:55',
//   '10:00 - 10:25',
//   '10:30 - 10:55',
//   '11:00 - 11:25',
//   '11:30 - 11:55',
//   '12:00 - 12:25',
//   '12:30 - 12:55',
//   '13:00 - 13:25',
//   '13:30 - 13:55',
//   '14:00 - 14:25',
//   '14:30 - 14:55',
//   '15:00 - 15:25',
//   '15:30 - 15:55',
//   '16:00 - 16:25',
//   '16:30 - 16:55',
//   '17:00 - 17:25',
//   '17:30 - 17:55',
//   '18:00 - 18:25',
//   '18:30 - 18:55'
// ];

// const reviews = [
//   Review('thanhnga266', 'This tutor is great', 5),
//   Review('bichthuy', 'He is very kind', 4),
//   Review('ngocnhu', 'This tutor always come late', 2),
//   Review('sontungnguyen151', 'He does not know how to teach apparently', 1),
//   Review('vunguyen', 'I am out of idea for review', 3),
//   Review('htho379', 'No idea what to say either', 4),
//   Review('ngocnhi', 'Neither do I', 2),
//   Review('QueenMarika', 'The Great Elden Ring was shattered', 5),
//   Review('Radagon', 'I am of the Golden Order', 2),
// ];

// const dummyUpcomingClass = [
//   {
//     "createdAtTimeStamp": 1628251989367,
//     "updatedAtTimeStamp": 1628251989400,
//     "id": "22f9e210-a712-43f8-b73c-8a036583c0ec",
//     "userId": "37264873-797b-473d-bf4c-fb017fec076f",
//     "scheduleDetailId": "022d0e8d-5957-4dd9-8a2e-862d34f7e0c9",
//     "tutorMeetingLink":
//         "/call/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJuaGlsYW01MjkyQGdtYWlsLmNvbSIsIm5hbWUiOiJuaGkgbGFtIn19LCJyb29tIjoiNmEwMzY4YjgtYzQ5YS00YmJiLWJhODMtYTY1ZDFlNWZiN2I1Iiwicm9vbU5hbWUiOiI2YTAzNjhiOC1jNDlhLTRiYmItYmE4My1hNjVkMWU1ZmI3YjUiLCJ1c2VyQ2FsbCI6eyJpZCI6IjM3MjY0ODczLTc5N2ItNDczZC1iZjRjLWZiMDE3ZmVjMDc2ZiIsImVtYWlsIjoicGhoYWkuZml0QGdtYWlsLmNvbSIsImdvb2dsZSI6IjEwMDk3MTkyMTY3NzQ1ODM5MDM3MiIsImZhY2Vib29rIjpudWxsLCJwYXNzd29yZCI6IiQyYSQxMiRqdDcyM1VqcXZxY1U2OTg5RGYzQ3NPTDY0aUZRT3BtV3V4R2NwdFU3OGJUY1E1azBqRzBtZSIsImF2YXRhciI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdncENfX2pzMURoSTl5bnNCY0syS042UGJNNDdENVowZWl2TXVfVktRPXM5Ni1jIiwibmFtZSI6IlBo4bqhbSBIYWkiLCJjb3VudHJ5IjpudWxsLCJwaG9uZSI6bnVsbCwibGFuZ3VhZ2UiOm51bGwsImJpcnRoZGF5IjpudWxsLCJyZXF1ZXN0UGFzc3dvcmQiOmZhbHNlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMS0wOC0wMVQxNzowMToyMi4yMDhaIiwidXBkYXRlZEF0IjoiMjAyMS0wOC0wMVQxNzowMToyMi4yMDhaIiwiZGVsZXRlZEF0IjpudWxsfSwidXNlckJlQ2FsbGVkIjp7ImlkIjoiODYyNDgxMzctNmY3ZC00Y2Y1LWFkMmUtMzRkYTQyNzIyYjI4IiwiZW1haWwiOiJuaGlsYW01MjkyQGdtYWlsLmNvbSIsImdvb2dsZSI6IjExNjk3Mzg1NjYzNDMzMTA2OTU1NCIsImZhY2Vib29rIjpudWxsLCJhdmF0YXIiOiJodHRwczovL2FwaS50dXRvcmluZy5sZXRzdHVkeS5pby9hdmF0YXIvODYyNDgxMzctNmY3ZC00Y2Y1LWFkMmUtMzRkYTQyNzIyYjI4YXZhdGFyMTYyODA1ODA0MjI0Ni5qcGciLCJuYW1lIjoibmhpIGxhbSIsImNvdW50cnkiOiJWTiIsInBob25lIjpudWxsLCJsYW5ndWFnZSI6bnVsbCwiYmlydGhkYXkiOiIxOTkyLTAyLTA1IiwicmVxdWVzdFBhc3N3b3JkIjpmYWxzZSwiaXNBY3RpdmF0ZWQiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjEtMDgtMDRUMDU6MjY6NDIuMzUxWiIsInVwZGF0ZWRBdCI6IjIwMjEtMDgtMDRUMDY6MjA6NDIuMzA3WiIsImRlbGV0ZWRBdCI6bnVsbH0sImlzVHV0b3IiOnRydWUsInN0YXJ0VGltZSI6IjIwMjEtMDgtMDZUMjE6MDA6MDArMDA6MDAiLCJlbmRTZXNzaW9uIjoiMjAyMS0wOC0wNlQyMTozMDowMCswMDowMCIsInRpbWVJblJvb20iOjE4MDAsImlhdCI6MTYyODI1MTk4OSwiZXhwIjoxNjI4Mjg1Mzk5LCJhdWQiOiJsaXZldHV0b3IiLCJpc3MiOiJsaXZldHV0b3IiLCJzdWIiOiJodHRwczovL21lZXQudHV0b3JpbmcubGV0c3R1ZHkuaW8ifQ.WidlN1AqoB-zo2z4LK7JY45KT11NGigR2LwNm9_H4b4",
//     "studentMeetingLink":
//         "/call/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJwaGhhaS5maXRAZ21haWwuY29tIiwibmFtZSI6IlBo4bqhbSBIYWkifX0sInJvb20iOiI2YTAzNjhiOC1jNDlhLTRiYmItYmE4My1hNjVkMWU1ZmI3YjUiLCJyb29tTmFtZSI6IjZhMDM2OGI4LWM0OWEtNGJiYi1iYTgzLWE2NWQxZTVmYjdiNSIsInVzZXJDYWxsIjp7ImlkIjoiMzcyNjQ4NzMtNzk3Yi00NzNkLWJmNGMtZmIwMTdmZWMwNzZmIiwiZW1haWwiOiJwaGhhaS5maXRAZ21haWwuY29tIiwiZ29vZ2xlIjoiMTAwOTcxOTIxNjc3NDU4MzkwMzcyIiwiZmFjZWJvb2siOm51bGwsInBhc3N3b3JkIjoiJDJhJDEyJGp0NzIzVWpxdnFjVTY5ODlEZjNDc09MNjRpRlFPcG1XdXhHY3B0VTc4YlRjUTVrMGpHMG1lIiwiYXZhdGFyIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FPaDE0R2dwQ19fanMxRGhJOXluc0JjSzJLTjZQYk00N0Q1WjBlaXZNdV9WS1E9czk2LWMiLCJuYW1lIjoiUGjhuqFtIEhhaSIsImNvdW50cnkiOm51bGwsInBob25lIjpudWxsLCJsYW5ndWFnZSI6bnVsbCwiYmlydGhkYXkiOm51bGwsInJlcXVlc3RQYXNzd29yZCI6ZmFsc2UsImlzQWN0aXZhdGVkIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDIxLTA4LTAxVDE3OjAxOjIyLjIwOFoiLCJ1cGRhdGVkQXQiOiIyMDIxLTA4LTAxVDE3OjAxOjIyLjIwOFoiLCJkZWxldGVkQXQiOm51bGx9LCJ1c2VyQmVDYWxsZWQiOnsiaWQiOiI4NjI0ODEzNy02ZjdkLTRjZjUtYWQyZS0zNGRhNDI3MjJiMjgiLCJlbWFpbCI6Im5oaWxhbTUyOTJAZ21haWwuY29tIiwiZ29vZ2xlIjoiMTE2OTczODU2NjM0MzMxMDY5NTU0IiwiZmFjZWJvb2siOm51bGwsImF2YXRhciI6Imh0dHBzOi8vYXBpLnR1dG9yaW5nLmxldHN0dWR5LmlvL2F2YXRhci84NjI0ODEzNy02ZjdkLTRjZjUtYWQyZS0zNGRhNDI3MjJiMjhhdmF0YXIxNjI4MDU4MDQyMjQ2LmpwZyIsIm5hbWUiOiJuaGkgbGFtIiwiY291bnRyeSI6IlZOIiwicGhvbmUiOm51bGwsImxhbmd1YWdlIjpudWxsLCJiaXJ0aGRheSI6IjE5OTItMDItMDUiLCJyZXF1ZXN0UGFzc3dvcmQiOmZhbHNlLCJpc0FjdGl2YXRlZCI6dHJ1ZSwiY3JlYXRlZEF0IjoiMjAyMS0wOC0wNFQwNToyNjo0Mi4zNTFaIiwidXBkYXRlZEF0IjoiMjAyMS0wOC0wNFQwNjoyMDo0Mi4zMDdaIiwiZGVsZXRlZEF0IjpudWxsfSwiaXNUdXRvciI6ZmFsc2UsInN0YXJ0VGltZSI6IjIwMjEtMDgtMDZUMjE6MDA6MDArMDA6MDAiLCJlbmRTZXNzaW9uIjoiMjAyMS0wOC0wNlQyMTozMDowMCswMDowMCIsInRpbWVJblJvb20iOjE4MDAsImlhdCI6MTYyODI1MTk4OSwiZXhwIjoxNjI4Mjg1Mzk5LCJhdWQiOiJsaXZldHV0b3IiLCJpc3MiOiJsaXZldHV0b3IiLCJzdWIiOiJodHRwczovL21lZXQudHV0b3JpbmcubGV0c3R1ZHkuaW8ifQ.Dex0QfcSnkiAYvbYU8sfH13-Gjg0vAlCi9-aXXJDLps",
//     "googleMeetLink": null,
//     "studentRequest": null,
//     "tutorReview": null,
//     "scoreByTutor": null,
//     "createdAt": "2021-08-06T12:13:09.367Z",
//     "updatedAt": "2021-08-06T12:13:09.400Z",
//     "recordUrl": null,
//     "cancelReasonId": null,
//     "lessonPlanId": null,
//     "cancelNote": null,
//     "calendarId": null,
//     "isDeleted": false,
//     "isTrial": false,
//     "convertedLesson": 0,
//     "scheduleDetailInfo": {
//       "startPeriodTimestamp": 1628258400000,
//       "endPeriodTimestamp": 1628260200000,
//       "id": "022d0e8d-5957-4dd9-8a2e-862d34f7e0c9",
//       "scheduleId": "99796a9b-def3-4d60-a47a-f7d685677785",
//       "startPeriod": "21:00",
//       "endPeriod": "21:30",
//       "createdAt": "2021-08-06T12:12:51.268Z",
//       "updatedAt": "2021-08-06T12:12:51.268Z",
//       "scheduleInfo": {
//         "date": "2021-08-06",
//         "startTimestamp": 1628258400000,
//         "endTimestamp": 1628260200000,
//         "id": "99796a9b-def3-4d60-a47a-f7d685677785",
//         "tutorId": "86248137-6f7d-4cf5-ad2e-34da42722b28",
//         "startTime": "21:00",
//         "endTime": "21:30",
//         "isDeleted": false,
//         "createdAt": "2021-08-06T12:12:51.263Z",
//         "updatedAt": "2021-08-06T12:12:51.263Z",
//         "tutorInfo": {
//           "id": "86248137-6f7d-4cf5-ad2e-34da42722b28",
//           "level": null,
//           "email": "nhilams@gmail.com",
//           "google": "116973856634331069554",
//           "facebook": null,
//           "apple": null,
//           "avatar":
//               "https://api.app.lettutor.com/avatar/86248137-6f7d-4cf5-ad2e-34da42722b28avatar1628058042246.jpg",
//           "name": "nhi lam",
//           "country": "VN",
//           "phone": null,
//           "language": null,
//           "birthday": "1992-02-05",
//           "requestPassword": false,
//           "isActivated": true,
//           "isPhoneActivated": null,
//           "requireNote": null,
//           "timezone": null,
//           "phoneAuth": null,
//           "isPhoneAuthActivated": false,
//           "studySchedule": null,
//           "canSendMessage": false,
//           "isPublicRecord": false,
//           "caredByStaffId": null,
//           "zaloUserId": null,
//           "createdAt": "2021-08-04T05:26:42.351Z",
//           "updatedAt": "2021-08-04T06:20:42.307Z",
//           "deletedAt": null,
//           "studentGroupId": null
//         }
//       }
//     },
//     "classReview": null,
//     "trialBookingReview": null,
//     "showRecordUrl": false,
//     "studentMaterials": [],
//     "feedbacks": []
//   }
// ];
