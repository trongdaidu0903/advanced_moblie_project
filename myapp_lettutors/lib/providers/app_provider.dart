import 'package:flutter/cupertino.dart';
import 'package:myapp_lettutors/models/languages/lang_vi.dart';
import 'package:myapp_lettutors/models/languages/language.dart';

class AppProvider extends ChangeNotifier {
  Language language = Vietnamese();

  void setLanguage(Language language) {
    this.language = language;
    notifyListeners();
  }
}
