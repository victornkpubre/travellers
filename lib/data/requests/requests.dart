// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';

part 'requests.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "device_name")
  String device_name;

  LoginRequest(
    this.email,
    this.password,
    this.device_name,
  );
}

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: "first_name")
  String first_name;
  @JsonKey(name: "last_name")
  String last_name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "device_name")
  String device_name;


  RegisterRequest(
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.password,
    this.device_name,
  );
}

@JsonSerializable()
class GoogleRegisterRequest {
  @JsonKey(name: "first_name")
  String first_name;
  @JsonKey(name: "last_name")
  String last_name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "sub")
  String sub;

  
  GoogleRegisterRequest(
    this.first_name,
    this.last_name,
    this.email,
    this.sub,
  );
}


@JsonSerializable()
class UpdateProfileRequest {
  @JsonKey(name: "user_id")
  String? user_id;
  @JsonKey(name: "first_name")
  String? first_name;
  @JsonKey(name: "last_name")
  String? last_name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "new_password")
  String? new_password;

  UpdateProfileRequest({
    this.user_id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.password,
    this.new_password
  });
}

@JsonSerializable()
class BookingRequest {
  @JsonKey(name: "client_id")
  String client_id;
  @JsonKey(name: "places")
  List<int>? places;
  @JsonKey(name: "festivals")
  List<int>? festivals;
  @JsonKey(name: "activities")
  List<int>? activities;

  BookingRequest(
    this.client_id,
    this.places,
    this.festivals,
    this.activities,
  );
}
