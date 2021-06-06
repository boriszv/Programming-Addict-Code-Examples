import 'package:flutter/material.dart';
import 'package:restaurant_reviews/sign_up/sign_up.dart';

import 'home.dart';
import 'login/email_login.dart';
import 'login/login.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'login': (_) => Login(),
  'email-login': (_) => EmailLogin(),
  'home': (_) => Home(),
  'sign-up': (_) => SignUp(),
};
