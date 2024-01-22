import 'package:myapp_lettutors/models/languages/language.dart';

class English extends Language {
  English() {
    id = 'EN';
  }

  // Login Text
  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get registerQuestion => 'Not a member yet?';

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get loginWith => 'Or continue with';

  @override
  String get invalidEmail => 'Email format must be abc@example.com';

  @override
  String get emptyEmail => 'Email cannot be empty';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get emptyPassword => 'Password cannot be empty';

  // Register Text
  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordEmpty => 'Please type your password again';

  @override
  String get confirmPasswordNotMatch => 'Re-typed password does not match';

  @override
  String get registerSuccess => 'Account Created Successfully';

  // Forgot Password Text
  @override
  String get enterEmailToResetPassword =>
      'Please enter your email address to receive recovery email.';

  @override
  String get sendRecoveryEmail => 'Send Recovery Email';

  @override
  String get sendRecoveryEmailSuccess => 'Recovery Email Sent Successfully';

  @override
  String get backToLogin => 'Go back to Login';

  @override
  String get account => "Account";

  @override
  String get becomeTeacher => "Become a Teacher";

  @override
  String get contact => "Contact";

  @override
  String get guide => "Guide";

  @override
  String get language => "Language";

  @override
  String get privatePolicy => "Private Policy";

  @override
  String get sighOut => "Sign Out";

  @override
  String get termAndCondition => "Term & Condition";

  @override
  String get selectLanguage => "Select Language";
}
