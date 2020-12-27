// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models-way2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SomeData _$SomeDataFromJson(Map<String, dynamic> json) {
  return SomeData(
    profile: json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SomeDataToJson(SomeData instance) => <String, dynamic>{
      'profile': instance.profile,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    age: json['age'] as int,
    gender: json['gender'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    contacts: (json['contacts'] as List)
        ?.map((e) =>
            e == null ? null : Contact.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'contacts': instance.contacts,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    street: json['street'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    postalCode: json['postalCode'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    type: json['type'] as String,
    number: json['number'] as String,
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'type': instance.type,
      'number': instance.number,
    };
