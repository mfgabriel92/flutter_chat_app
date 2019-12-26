import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/widgets/button.dart';
import 'package:flutter_chat_app/widgets/text_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool isLoggingIn = false;

  Future onLoginClick(BuildContext context) async {
    setState(() => isLoggingIn = true);

    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } catch (e) {
      print(e);
    } finally {
      reset();
      setState(() => isLoggingIn = false);
    }
  }

  void reset() {
    email = '';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoggingIn,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 100.0,
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                TextInput(
                  onChanged: (value) => email = value,
                  hintText: 'E-mail address',
                ),
                SizedBox(height: 16.0),
                TextInput(
                  onChanged: (value) => password = value,
                  hintText: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    text: 'Login',
                    color: Colors.blueGrey,
                    onPressed: () async => await onLoginClick(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
