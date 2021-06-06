import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviews/login/shared.dart';
import 'package:restaurant_reviews/utils/dialog_utils.dart';
import 'package:restaurant_reviews/widgets/buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var loading = false;
  
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

            if (loading) ...[
              const SizedBox(height: 15),
              const Center(child: const CircularProgressIndicator()),
            ],

            if (!loading) ...[
              _Button(
                text: 'Log in with email',
                color: Colors.grey.shade600,
                image: const AssetImage('assets/images/email.png'),
                onPressed: () {
                  Navigator.of(context).pushNamed('email-login');
                },
              ),
              _Button(
                  text: 'Log in with Facebook',
                  color: Colors.blue,
                  image: const AssetImage('assets/images/facebook.png')),
              _Button(
                  text: 'Log in with Google',
                  color: Colors.green,
                  image: const AssetImage('assets/images/google.png'),
                  onPressed: () {
                    _logInWithGoogle();
                  },  
                ),
              const SizedBox(height: 20),
              const _Divider(),
              SubmitButton(
                text: 'Sign up',
                padding: 22,
                onPressed: () {
                  Navigator.of(context).pushNamed('sign-up');
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _logInWithGoogle() async {
    setState(() { loading = true; });

    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        setState(() { loading = false; });
        return;
      }

      final googleSignInAuthentication = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance.collection('users').add({
        'email': googleSignInAccount.email,
        'imageUrl': googleSignInAccount.photoUrl,
        'name': googleSignInAccount.displayName,
      });

      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        showOkDialog(context, title: 'Login failed',
          content: 'This account already exists with a different provider (Facebook or Email)');

      } else if (e.code == 'invalid-credential') {
        showOkDialog(context, title: 'Login failed', content: 'An unknown error occurred');
      }
    } catch (e) {
      showOkDialog(context, title: 'Login failed', content: 'An unknown error occurred');

    } finally {
      setState(() { loading = false; });
    }
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Divider(color: Colors.grey.shade500),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final ImageProvider image;
  final String text;
  final VoidCallback onPressed;

  _Button({this.color, this.image, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              const SizedBox(width: 5),
              Image(
                image: image,
                width: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text, style: TextStyle(color: color, fontSize: 18)),
                    const SizedBox(width: 35),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
