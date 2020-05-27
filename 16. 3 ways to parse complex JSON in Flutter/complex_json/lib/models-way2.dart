import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models-way2.g.dart';

@JsonSerializable()
class SomeData {
  Profile profile;

  SomeData({@required this.profile});

  static const fromJson = _$SomeDataFromJson;
  Map<String, dynamic> toJson() => _$SomeDataToJson(this);
}

@JsonSerializable()
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

  static const fromJson = _$ProfileFromJson;
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
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

  static const fromJson = _$AddressFromJson;
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Contact {
  String type;
  String number;

  Contact({
    @required this.type,
    @required this.number,
  });

  static const fromJson = _$ContactFromJson;
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}