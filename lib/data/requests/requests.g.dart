// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      json['email'] as String,
      json['password'] as String,
      json['device_name'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_name': instance.device_name,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      json['first_name'] as String,
      json['last_name'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['password'] as String,
      json['device_name'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'device_name': instance.device_name,
    };

GoogleRegisterRequest _$GoogleRegisterRequestFromJson(
        Map<String, dynamic> json) =>
    GoogleRegisterRequest(
      json['first_name'] as String,
      json['last_name'] as String,
      json['email'] as String,
      json['sub'] as String,
    );

Map<String, dynamic> _$GoogleRegisterRequestToJson(
        GoogleRegisterRequest instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'sub': instance.sub,
    };

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      user_id: json['user_id'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      new_password: json['new_password'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'new_password': instance.new_password,
    };

BookingRequest _$BookingRequestFromJson(Map<String, dynamic> json) =>
    BookingRequest(
      json['client_id'] as String,
      (json['places'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['festivals'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['activities'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$BookingRequestToJson(BookingRequest instance) =>
    <String, dynamic>{
      'client_id': instance.client_id,
      'places': instance.places,
      'festivals': instance.festivals,
      'activities': instance.activities,
    };
