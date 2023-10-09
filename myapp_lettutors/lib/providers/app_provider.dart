import 'package:flutter/cupertino.dart';
import 'package:myapp_lettutors/models/languages/lang_en.dart';
import 'package:myapp_lettutors/models/languages/language.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  Language language = English();

  void setLanguage(Language language) {
    this.language = language;
    notifyListeners();
  }
}
