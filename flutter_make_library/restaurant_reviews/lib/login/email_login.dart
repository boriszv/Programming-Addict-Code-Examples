import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviews/login/shared.dart';
import 'package:restaurant_reviews/utils/dialog_utils.dart';
import 'package:restaurant_reviews/widgets/buttons.dart';

class EmailLogin extends StatefulWidget {
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var isLoggingIn = false;

  void _logIn() async {
    try {
      setState(() {
        isLoggingIn = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
    } on FirebaseAuthException catch (e) {
      await _handleSignInError(e);
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  Future _handleSignInError(FirebaseAuthException e) async {
    var message = '';

    switch (e.code) {
      case 'invalid-email':
        message = 'Email was invalid';
        break;
      case 'user-disabled':
        message = 'This user is disabled';
        break;
      case 'user-not-found':
        message = 'This user does not exist';
        break;
      case 'wrong-password':
        message = 'Incorrect password';
        break;
      default:
        throw Exception('Invalid firebase error message');
    }

    showOkDialog(context, title: 'Login failed', content: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginText('Restaurants'),
            const SizedBox(height: 5),
            const LoginText('Log in'),
            const SizedBox(height: 25),
            _TextField(
              controller: _emailController,
              label: 'Email',
            ),
            const SizedBox(height: 16),
            _TextField(
              controller: _passwordController,
              label: 'Password',
              password: true,
            ),
            if (isLoggingIn) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ],
            if (!isLoggingIn)
              SubmitButton(
                text: 'Log in',
                padding: 16,
                onPressed: () {
                  _logIn();
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key key,
    @required this.label,
    @required this.controller,
    this.password = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        obscureText: password,
      ),
    );
  }
}
