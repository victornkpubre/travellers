// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/location.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "errors")
  String? errors;

  BaseResponse({
    this.status,
    this.message,
    this.errors,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return _$BaseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BaseResponseToJson(this);
  }
}

@JsonSerializable()
class AuthResponse extends BaseResponse{
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "user")
  UserResponse? user;

  AuthResponse(this.token, this.user);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResponseToJson(this);
  }
}

@JsonSerializable()
class UserResponse extends BaseResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "first_name")
  String? first_name;
  @JsonKey(name: "last_name")
  String? last_name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "is_phone_verified")
  int? is_phone_verified;

  UserResponse();

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return _$UserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserResponseToJson(this);
  }
}

@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: "places")
  List<PlaceResponse>? places;
  @JsonKey(name: "festivals")
  List<FestivalResponse>? festivals;
  @JsonKey(name: "emotions")
  List<EmotionResponse>? emotions;
  @JsonKey(name: "activities")
  List<ActivityResponse>? activities;
  HomeDataResponse({
    this.places,
    this.festivals,
    this.emotions,
    this.activities,
  });

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeDataResponseToJson(this);
  }
}

@JsonSerializable()
class PlaceResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "img")
  String? img;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "location")
  LocationResponse? location;
  @JsonKey(name: "stars")
  int? stars;
  @JsonKey(name: "people")
  int? people;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "activities")
  List<ActivityResponse>? activities;
  PlaceResponse({
    this.name,
    this.img,
    this.description,
    this.location,
    this.stars,
    this.people,
    this.price,
    this.activities,
  });

  factory PlaceResponse.fromJson(Map<String, dynamic> json) {
    return _$PlaceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlaceResponseToJson(this);
  }
  
}



@JsonSerializable()
class FestivalResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "img")
  String? img;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "location")
  LocationResponse? location;
  @JsonKey(name: "people")
  int? people;
  @JsonKey(name: "activities")
  List<ActivityResponse>? activities;
  FestivalResponse({
    this.name,
    this.img,
    this.description,
    this.location,
    this.people,
    this.activities,
  });

  factory FestivalResponse.fromJson(Map<String, dynamic> json) {
    return _$FestivalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FestivalResponseToJson(this);
  }

}

@JsonSerializable()
class EmotionResponse extends BaseResponse {
  @JsonKey(name: "img")
  String? img;
  @JsonKey(name: "place")
  PlaceResponse? place;
  @JsonKey(name: "festival")
  FestivalResponse? festival;
  @JsonKey(name: "activity")
  ActivityResponse? activity; 
  EmotionResponse({
    this.img,
    this.place,
    this.festival,
    this.activity,
  });

  factory EmotionResponse.fromJson(Map<String, dynamic> json) {
    return _$EmotionResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmotionResponseToJson(this);
  }

}

@JsonSerializable()
class ActivityResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "img")
  String? img;
  ActivityResponse({
    this.id,
    this.name,
    this.img,
  });

  factory ActivityResponse.fromJson(Map<String, dynamic> json) {
    return _$ActivityResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ActivityResponseToJson(this);
  }

}

@JsonSerializable()
class LocationResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  LocationResponse({
    this.id,
    this.name
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return _$LocationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LocationResponseToJson(this);
  }

}


@JsonSerializable()
class UserPlaceResponse extends BaseResponse {
  @JsonKey(name: "places")
  List<PlaceResponse>? places;
  UserPlaceResponse({
    this.places,
  });

  factory UserPlaceResponse.fromJson(Map<String, dynamic> json) {
    return _$UserPlaceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserPlaceResponseToJson(this);
  }

}

@JsonSerializable()
class UserFestivalResponse extends BaseResponse {
  @JsonKey(name: "festivals")
  List<FestivalResponse>? festivals;
  UserFestivalResponse({
    this.festivals,
  });

  factory UserFestivalResponse.fromJson(Map<String, dynamic> json) {
    return _$UserFestivalResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserFestivalResponseToJson(this);
  }

}


@JsonSerializable()
class BookingsResponse extends BaseResponse {
  @JsonKey(name: "bookings")
  List<BookingResponse>? bookings;
  BookingsResponse({
    this.bookings,
  });

  factory BookingsResponse.fromJson(Map<String, dynamic> json) {
    return _$BookingsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BookingsResponseToJson(this);
  }

}

@JsonSerializable()
class BookingResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "client_id")
  int? client_id;

  @JsonKey(name: "places")
  List<PlaceResponse>? places;

  @JsonKey(name: "festivals")
  List<FestivalResponse>? festivals;
  
  @JsonKey(name: "activities")
  List<ActivityResponse>? activities;
  
  BookingResponse({
    required this.id,
    required this.client_id,
    required this.places,
    required this.festivals,
    required this.activities,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return _$BookingResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BookingResponseToJson(this);
  }

}
