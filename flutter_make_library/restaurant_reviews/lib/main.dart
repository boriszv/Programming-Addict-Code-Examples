import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_reviews/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return MaterialApp(
            title: 'Restaurant reviews',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            initialRoute:
                FirebaseAuth.instance.currentUser != null ? 'home' : 'login',
            routes: appRoutes,
          );
        });
  }
}
