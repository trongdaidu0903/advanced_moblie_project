import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/user/learn_topic.dart';
import 'package:myapp_lettutors/models/user/test_preparation.dart';
import 'package:myapp_lettutors/models/user/token.dart';
import 'package:myapp_lettutors/models/user/user.dart';

class AuthProvider extends ChangeNotifier {
  User? currentUser;
  Token? token;
  List<LearnTopic> learnTopics = [];
  List<TestPreparation> testPreparations = [];

  void setLearnTopic(List<LearnTopic> learnTopics) {
    this.learnTopics = learnTopics;
    notifyListeners();
  }

  void setTestPreparation(List<TestPreparation> testPreparations) {
    this.testPreparations = testPreparations;
    notifyListeners();
  }

  void setUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  void logIn(User user, Token token) {
    currentUser = user;
    this.token = token;
    notifyListeners();
  }

  void logOut() {
    token = null;
    notifyListeners();
  }
}
