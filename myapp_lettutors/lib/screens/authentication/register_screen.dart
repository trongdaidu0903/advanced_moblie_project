import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final String _emailErrorText = '';
  final String _passwordErrorText = '';
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue[400]),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Image.asset(
            "assets/logo/lettutor.png",
            height: 250,
            width: double.infinity,
          ),
          const Text(
            "Register Let Tutor",
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
                //_handleValidation(lang);
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
                //_handleValidation(lang);
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
        ],
      ),
    );
  }
}
