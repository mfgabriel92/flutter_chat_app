import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/widgets/button.dart';
import 'package:flutter_chat_app/widgets/text_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool isRegistering = false;

  Future onRegisterClick(BuildContext context) async {
    setState(() => isRegistering = true);

    try {
      final user = await _auth.createUserWithEmailAndPassword(
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
      setState(() => isRegistering = false);
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
        title: Text('Register'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isRegistering,
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
                  keyboardType: TextInputType.emailAddress,
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
                    text: 'Register',
                    color: Colors.blueGrey,
                    onPressed: () async => await onRegisterClick(context),
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
