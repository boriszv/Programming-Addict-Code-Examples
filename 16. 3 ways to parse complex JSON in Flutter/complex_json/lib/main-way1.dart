import 'dart:convert';

import 'package:complex_json/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

const URL =
    'https://gist.githubusercontent.com/boriszv/c9c2ac718614a335cc2e9a85321dcaa5/raw/799590fff5bb5ff424117f441bfa42b37f9e4a34/examplejson.json';

Future fetchData() {
  return http.get(URL)
    .then((value) {
      final jsonBody = json.decode(value.body);
      
      final dataToReturn = SomeData(
        profile: Profile(
          firstName: jsonBody['profile']['firstName'],
          lastName: jsonBody['profile']['lastName'],
          age: jsonBody['profile']['age'] as int,
          gender: jsonBody['profile']['gender'],
          address: Address(
            street: jsonBody['profile']['address']['street'],
            city: jsonBody['profile']['address']['city'],
            state: jsonBody['profile']['address']['state'],
            postalCode: jsonBody['profile']['address']['postalCode'],
          ),
          contacts: jsonBody['profile']['contacts'].map<Contact>((item) {
            return Contact(
              type: item['type'],
              number: item['number'],
            );
          }).toList()
        )
      );

      return dataToReturn;
    });
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User profile')),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: UserProfileInfo(snapshot.data),
          );
        },
      ),
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  final SomeData data;

  UserProfileInfo(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('First name: ' + data.profile.firstName, style: TextStyle(fontSize: 24)),
        Text('Last name: ' + data.profile.lastName, style: TextStyle(fontSize: 24)),
        Text('Age: ' + data.profile.age.toString(), style: TextStyle(fontSize: 24)),
        Text('Gender:  ' + data.profile.gender, style: TextStyle(fontSize: 24)),
        Text('Address:  ', style: TextStyle(fontSize: 24)),
        Text('       Street: ' + data.profile.address.street, style: TextStyle(fontSize: 24)),
        Text('       City: ' + data.profile.address.city, style: TextStyle(fontSize: 24)),
        Text('       State: ' + data.profile.address.state, style: TextStyle(fontSize: 24)),
        Text('       Postal code: ' + data.profile.address.postalCode, style: TextStyle(fontSize: 24)),
        Container(height: 20),
        Text('       Contacts: ', style: TextStyle(fontSize: 24)),
        Container(height: 15),

        ...data.profile.contacts.map<Widget>((contact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('       Type: ' + contact.type, style: TextStyle(fontSize: 24)),
              Text('       Number: ' + contact.number, style: TextStyle(fontSize: 24)),
              Container(height: 15),
            ],
          );
        }).toList()
      ],
    );
  }
}
