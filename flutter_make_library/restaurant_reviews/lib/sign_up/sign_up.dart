import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviews/utils/dialog_utils.dart';
import 'package:restaurant_reviews/widgets/app_toolbar.dart';
import 'package:restaurant_reviews/widgets/buttons.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbar(title: 'Sign up'),
      body: Form(
        key: _formKey,
        child: ListView(children: [
          const SizedBox(height: 30),

          _TextField(label: 'Name', controller: _nameController,
              validator: _requiredValidator),
          const SizedBox(height: 15),

          _TextField(label: 'Email', controller: _emailController,
              email: true,
              validator: _requiredValidator,),
          const SizedBox(height: 15),

          _TextField(label: 'Password', controller: _passwordController,
            validator: _requiredValidator,
            password: true,
          ),
          const SizedBox(height: 15),

          _TextField(label: 'Confirm Password', controller: _confirmPasswordController,
            validator: _confirmPasswordValidator,
            password: true,
          ),
          const SizedBox(height: 10),

          if (loading) ...[
            Center(child: CircularProgressIndicator()),
          ],

          if (!loading) ...[
            SubmitButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _signUp();
                }
              },
              padding: 16,
            ),
          ]
        ]),
      ),
    );
  }

  Future _signUp() async {
    setState(() { loading = true; });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await FirebaseFirestore.instance.collection('users').add({
        'email': _emailController.text,
        'imageUrl': null,
        'name': _nameController.text,
      });

      await showOkDialog(context, title: 'Sign up succeeded', content: 'Your account was created, you can now log in');
      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
      setState(() { loading = false; });
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'This email is already in use';
        break;
      case 'invalid-email':
        messageToDisplay = 'The email you ented is invalid';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'This operation is not allowed';
        break;
      case 'weak-password':
        messageToDisplay = 'The password you entered is too weak';
        break;
      default:
        messageToDisplay = 'An unknown error occurred';
        break;
    }

    showOkDialog(context, title: 'Sign up failed', content: messageToDisplay);
  }

  String _requiredValidator(String text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String _confirmPasswordValidator(String confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'This field is required';
    }

    if (_passwordController.text != confirmPasswordText) {
      return "Passwords don't match";
    }
    return null;
  }
}

class _TextField extends StatelessWidget {

  const _TextField({
    Key key,
    @required this.label,
    @required this.controller,
    this.validator,
    this.password = false,
    this.email = false,

  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool password;
  final bool email;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    final keyboardType = _resolveKeyboardType();

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: password,
        validator: validator,
      ),
    );
  }

  TextInputType _resolveKeyboardType() {
    if (email) {
      return TextInputType.emailAddress;
    }
    return null;
  }
}

