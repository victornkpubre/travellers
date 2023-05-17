// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  int is_phone_verified;

  User(
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.is_phone_verified,
  );

  User copyWith({
    int? id,
    String? first_name,
    String? last_name,
    String? email,
    String? phone,
    int? is_phone_verified,
  }) {
    return User(
      id ?? this.id,
      first_name ?? this.first_name,
      last_name ?? this.last_name,
      email ?? this.email,
      phone ?? this.phone,
      is_phone_verified ?? this.is_phone_verified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'is_phone_verified': is_phone_verified,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] as int,
      map['first_name'] as String,
      map['last_name'] as String,
      map['email'] as String,
      map['phone'] as String,
      map['is_phone_verified'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, first_name: $first_name, last_name: $last_name, email: $email, phone: $phone, is_phone_verified: $is_phone_verified)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.first_name == first_name &&
      other.last_name == last_name &&
      other.email == email &&
      other.phone == phone &&
      other.is_phone_verified == is_phone_verified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      is_phone_verified.hashCode;
  }
}

