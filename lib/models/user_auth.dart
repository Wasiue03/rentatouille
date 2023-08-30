import 'dart:convert';

class UserAuth {
  final String email;
  final String id;

  UserAuth({
    required this.email,
    required this.id,
  });

  UserAuth copyWith({
    String? email,
    String? id,
  }) {
    return UserAuth(email: email ?? this.email, id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id': id,
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      email: map['email'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuth.fromJson(String source) =>
      UserAuth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthData( email: $email, id: $id)';

  @override
  bool operator ==(covariant UserAuth other) {
    if (identical(this, other)) return true;

    return other.email == email && other.id == id;
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode;
}
