// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      json['token'] as String?,
      json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'token': instance.token,
      'user': instance.user,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?
  ..errors = json['errors'] as String?
  ..id = json['id'] as int?
  ..first_name = json['first_name'] as String?
  ..last_name = json['last_name'] as String?
  ..email = json['email'] as String?
  ..phone = json['phone'] as String?
  ..is_phone_verified = json['is_phone_verified'] as int?;

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'is_phone_verified': instance.is_phone_verified,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      places: (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      festivals: (json['festivals'] as List<dynamic>?)
          ?.map((e) => FestivalResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      emotions: (json['emotions'] as List<dynamic>?)
          ?.map((e) => EmotionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => ActivityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'places': instance.places,
      'festivals': instance.festivals,
      'emotions': instance.emotions,
      'activities': instance.activities,
    };

PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) =>
    PlaceResponse(
      name: json['name'] as String?,
      img: json['img'] as String?,
      description: json['description'] as String?,
      location: json['location'] == null
          ? null
          : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
      stars: json['stars'] as int?,
      people: json['people'] as int?,
      price: json['price'] as int?,
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => ActivityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?
      ..id = json['id'] as int?;

Map<String, dynamic> _$PlaceResponseToJson(PlaceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
      'description': instance.description,
      'location': instance.location,
      'stars': instance.stars,
      'people': instance.people,
      'price': instance.price,
      'activities': instance.activities,
    };

FestivalResponse _$FestivalResponseFromJson(Map<String, dynamic> json) =>
    FestivalResponse(
      name: json['name'] as String?,
      img: json['img'] as String?,
      description: json['description'] as String?,
      location: json['location'] == null
          ? null
          : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
      people: json['people'] as int?,
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => ActivityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?
      ..id = json['id'] as int?;

Map<String, dynamic> _$FestivalResponseToJson(FestivalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
      'description': instance.description,
      'location': instance.location,
      'people': instance.people,
      'activities': instance.activities,
    };

EmotionResponse _$EmotionResponseFromJson(Map<String, dynamic> json) =>
    EmotionResponse(
      img: json['img'] as String?,
      place: json['place'] == null
          ? null
          : PlaceResponse.fromJson(json['place'] as Map<String, dynamic>),
      festival: json['festival'] == null
          ? null
          : FestivalResponse.fromJson(json['festival'] as Map<String, dynamic>),
      activity: json['activity'] == null
          ? null
          : ActivityResponse.fromJson(json['activity'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$EmotionResponseToJson(EmotionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'img': instance.img,
      'place': instance.place,
      'festival': instance.festival,
      'activity': instance.activity,
    };

ActivityResponse _$ActivityResponseFromJson(Map<String, dynamic> json) =>
    ActivityResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      img: json['img'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$ActivityResponseToJson(ActivityResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
    };

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'name': instance.name,
    };

UserPlaceResponse _$UserPlaceResponseFromJson(Map<String, dynamic> json) =>
    UserPlaceResponse(
      places: (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$UserPlaceResponseToJson(UserPlaceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'places': instance.places,
    };

UserFestivalResponse _$UserFestivalResponseFromJson(
        Map<String, dynamic> json) =>
    UserFestivalResponse(
      festivals: (json['festivals'] as List<dynamic>?)
          ?.map((e) => FestivalResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$UserFestivalResponseToJson(
        UserFestivalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'festivals': instance.festivals,
    };

BookingsResponse _$BookingsResponseFromJson(Map<String, dynamic> json) =>
    BookingsResponse(
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => BookingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$BookingsResponseToJson(BookingsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'bookings': instance.bookings,
    };

BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) =>
    BookingResponse(
      id: json['id'] as int?,
      client_id: json['client_id'] as int?,
      places: (json['places'] as List<dynamic>?)
          ?.map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      festivals: (json['festivals'] as List<dynamic>?)
          ?.map((e) => FestivalResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      activities: (json['activities'] as List<dynamic>?)
          ?.map((e) => ActivityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..errors = json['errors'] as String?;

Map<String, dynamic> _$BookingResponseToJson(BookingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'id': instance.id,
      'client_id': instance.client_id,
      'places': instance.places,
      'festivals': instance.festivals,
      'activities': instance.activities,
    };
