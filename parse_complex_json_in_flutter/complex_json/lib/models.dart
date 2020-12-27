

import 'package:flutter/material.dart';

class SomeData {
  Profile profile;

  SomeData({@required this.profile});
}

class Profile {
  String firstName;
  String lastName;
  int age;
  String gender;
  Address address;
  List<Contact> contacts;

  Profile({
    @required this.firstName,
    @required this.lastName,
    @required this.age,
    @required this.gender,
    @required this.address,
    @required this.contacts,
  });
}

class Address {
  String street;
  String city;
  String state;
  String postalCode;

  Address({
    @required this.street,
    @required this.city,
    @required this.state,
    @required this.postalCode,
  });
}

class Contact {
  String type;
  String number;

  Contact({
    @required this.type,
    @required this.number,
  });
}