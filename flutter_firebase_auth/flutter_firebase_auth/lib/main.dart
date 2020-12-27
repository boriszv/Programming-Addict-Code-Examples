import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}


class LoginPage extends StatelessWidget {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                _title(),
                SizedBox(height: 32),
                _emailAddress(),
                SizedBox(height: 12),
                _password(),
                SizedBox(height: 30),
                _login(context),
                SizedBox(height: 30),
                _separator(context),
                SizedBox(height: 30),
                _forgotPassword(context),
                SizedBox(height: 6),
                _signUp(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _title() => Text('Instagram clone', style: TextStyle(fontFamily: 'Satisfy', fontSize: 44));

  _emailAddress() => CupertinoTextField(
    controller: _emailController,
    placeholder: 'Email address',
  );

  _password() => CupertinoTextField(
    controller: _passwordController,
    obscureText: true,
    placeholder: 'Password',
  );

  _login(BuildContext context) => SizedBox(
    width: double.infinity,
    child: CupertinoButton(
      minSize: 35,
      padding: EdgeInsets.all(0),
      child: Text('Log in', style: TextStyle(color: Colors.white, fontSize: 15)),
      color: Color(0xFF0077C5),
      onPressed: () {
        _attemptLogin(context);
      },
    ),
  );

  _separator(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.37,
        child: Divider(color: Colors.grey[400]),
      ),
      Text('or', style: TextStyle(color: Colors.grey[500], fontSize: 17)),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.37,
        child: Divider(color: Colors.grey[400]),
      ),
    ],
  );

  _forgotPassword(BuildContext context) => GestureDetector(
    child: Text('Forgot password?'),
    onTap: () {},
  );

  _signUp(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account?"),
      SizedBox(width: 5),
      GestureDetector(
        child: Text("Sign up", style: TextStyle(color: Color(0xFF0077C5), fontWeight: FontWeight.w600)),
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (_) => SignUpPage()));
        },
      )
    ],
  );

  void _attemptLogin(BuildContext context) async {
    if (_emailController.text == null || _emailController.text.trim().isEmpty) {
      return;
    }
    if (_passwordController.text == null || _passwordController.text.trim().isEmpty) {
      return;
    }

    try {
      await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );

      if (!auth.currentUser.emailVerified) {
        final sendVerificationEmailResult = await showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
          title: Text('Email not verified!'),
          content: Text('Do you want to resend the confirmation email?'),
          actions: [
            CupertinoDialogAction(child: Text('Yes'), onPressed: () { Navigator.of(context).pop(true); },),
            CupertinoDialogAction(child: Text('No'), onPressed: () { Navigator.of(context).pop(false); },)
          ],
        ));
        if (sendVerificationEmailResult) {
          await auth.currentUser.sendEmailVerification();
        }
        return;
      }

    } on FirebaseAuthException catch (e) {
      var errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User not found';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        default: 
          errorMessage = 'Unknown error';
      }
      showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
        title: Text('Login failed'),
        content: Text(errorMessage),
        actions: [
          CupertinoDialogAction(child: Text('OK'), onPressed: () { Navigator.of(context).pop(); },),
        ],
      ));
    }
  }
}