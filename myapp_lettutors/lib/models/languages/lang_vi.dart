import 'package:myapp_lettutors/models/languages/language.dart';

class Vietnamese extends Language {
  Vietnamese() {
    id = 'VI';
  }
  // Login Text
  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get registerQuestion => 'Chưa có tài khoản?';

  @override
  String get register => 'Đăng ký';

  @override
  String get login => 'Đăng nhập';

  @override
  String get forgotPassword => 'Quên mật khẩu';

  @override
  String get loginWith => 'Hoặc đăng nhập bằng';

  @override
  String get invalidEmail => 'Email phải có dạng abc@example.com';

  @override
  String get emptyEmail => 'Vui lòng nhập Email';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get emptyPassword => 'Vui lòng nhập mật khẩu';

  @override
  String get registerSuccess => 'Tạo tài khoản thành công';

  // Register Text
  @override
  String get alreadyHaveAccount => 'Đã có tài khoản?';

  @override
  String get confirmPassword => 'Nhập lại mật khẩu';

  @override
  String get confirmPasswordEmpty => 'Vui lòng nhập lại mật khẩu';

  @override
  String get confirmPasswordNotMatch => 'Mật khẩu không khớp';

  // Forgot Password Text
  @override
  String get enterEmailToResetPassword =>
      'Vui lòng nhập địa chỉ email của bạn để nhận email đặt lại mật khẩu';

  @override
  String get sendRecoveryEmail => 'Gửi Email';

  @override
  String get sendRecoveryEmailSuccess =>
      'Gửi Email đặt lại mật khẩu thành công';

  @override
  String get backToLogin => 'Quay về đăng nhập';

  @override
  String get account => "Tài khoản";

  @override
  String get language => "Ngôn ngữ";

  @override
  String get becomeTeacher => "Trở thành giáo viên";

  @override
  String get privatePolicy => "Chính sách bảo mật";

  @override
  String get contact => "Liên hệ";

  @override
  String get guide => "Hướng dẫn";

  @override
  String get sighOut => "Đăng xuất";

  @override
  String get termAndCondition => "Điều khoản và điều kiện";

  @override
  String get selectLanguage => "Chọn ngôn ngữ";

  @override
  String get lightTheme => "Chế độ sáng";

  @override
  String get darkTheme => "Chế độ tối";

  @override
  String get selectTheme => "Đế độ xem";

  @override
  String get systemDefault => "Mặc định hệ thống";
}
