import 'dart:convert';
import 'package:flutter/foundation.dart';

enum UserType {
  renter,
  seller,
}

class UserAuth {
  final String email;
  final String id;
  final UserType userType;

  UserAuth({
    required this.email,
    required this.id,
    required this.userType,
  });

  UserAuth copyWith({
    String? email,
    String? id,
    UserType? userType,
  }) {
    return UserAuth(
      email: email ?? this.email,
      id: id ?? this.id,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id': id,
      'userType': userType.toString(), // Store userType as a string
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      email: map['email'] as String,
      id: map['id'] as String,
      userType: map['userType'] == 'UserType.renter'
          ? UserType.renter
          : UserType.seller, // Convert stored string back to enum
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuth.fromJson(String source) =>
      UserAuth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthData( email: $email, id: $id, userType: $userType)';

  @override
  bool operator ==(covariant UserAuth other) {
    if (identical(this, other)) return true;

    return other.email == email && other.id == id && other.userType == userType;
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode ^ userType.hashCode;
}
