import 'package:flutter/material.dart';
import 'package:myapp_lettutors/models/languages/language.dart';
import 'package:myapp_lettutors/providers/app_provider.dart';
import 'package:myapp_lettutors/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailController = TextEditingController(text: "phhai.fit@gmail.com");
  final _passwordController = TextEditingController(text: "123456");
  final _confirmPasswordController = TextEditingController();

  String _emailErrorText = '';
  String _passwordErrorText = '';
  String chosenLanguage = 'English';

  void _handleValidation(Language language) {
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (_emailController.text.isEmpty) {
      _emailErrorText = language.emptyEmail;
    } else if (!emailRegExp.hasMatch(_emailController.text)) {
      _emailErrorText = language.invalidEmail;
    } else {
      _emailErrorText = '';
    }

    if (_passwordController.text.isEmpty) {
      _passwordErrorText = language.emptyPassword;
    } else if (_passwordController.text.length < 6) {
      _passwordErrorText = language.passwordTooShort;
    } else {
      _passwordErrorText = '';
    }

    if (_confirmPasswordController.text.isEmpty) {
    } else if (_confirmPasswordController.text.length < 6) {
    } else if (_confirmPasswordController.text != _passwordController.text) {
    } else {}
    setState(() {});
  }

  void _handleRegister(Language language) async {
    try {
      await AuthService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(language.registerSuccess)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Register: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final lang = appProvider.language;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue[400]),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Image.asset(
            "assets/logo/lettutor.png",
            height: 150,
            width: double.infinity,
          ),
          const Text(
            "Register Account",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Email",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation(lang);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'abc@example.com',
                errorText: _emailErrorText.isEmpty ? null : _emailErrorText,
                prefixIcon: Icon(
                  Icons.mail,
                  color:
                      _emailErrorText.isEmpty ? Colors.blue : Colors.red[700],
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Password",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation(lang);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: '******',
                errorText:
                    _passwordErrorText.isEmpty ? null : _passwordErrorText,
                prefixIcon: Icon(
                  Icons.lock,
                  color: _passwordErrorText.isEmpty
                      ? Colors.blue
                      : Colors.red[700],
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextButton(
              onPressed: () {
                _handleRegister(lang);
              },
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
