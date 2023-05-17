import 'package:travellers/data/mappers/extensions.dart';
import 'package:travellers/data/responses/responses.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/emotion.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/home_data.dart';
import 'package:travellers/domain/entities/location.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';

const EMPTY = "";
const ZERO = 0;
final DEFAULT_LOCATION = Location(0, "Default");


extension AuthenticationResponseMapper on AuthResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.token?.orEmpty() ?? EMPTY, 
      this?.user?.toDomain()
    );
  }
}

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      this?.id?.orZero() ?? ZERO,
      this?.first_name?.orEmpty() ?? EMPTY,
      this?.last_name?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.is_phone_verified?.orZero() ?? ZERO,
    );
  }
}

extension HomeDataResponseMapper on HomeDataResponse? {
  HomeDataObject toDomain() {
    return HomeDataObject(
      this?.places?.map((place) => place.toDomain()).toList() ?? <Place>[],
      this?.festivals?.map((festival) => festival.toDomain()).toList() ?? <Festival>[],
      this?.emotions?.map((emotion) => emotion.toDomain()).toList() ?? <Emotion>[],
      this?.activities?.map((activity) => activity.toDomain()).toList() ?? <Activity>[],
    );
  }
}

extension PlaceResponseMapper on PlaceResponse? {
  Place toDomain() {
    return Place(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
      this?.img?.orEmpty() ?? EMPTY,
      this?.description?.orEmpty() ?? EMPTY,
      this?.location?.toDomain()?? DEFAULT_LOCATION,
      this?.stars?.orZero() ?? ZERO,
      this?.people?.orZero() ?? ZERO,
      this?.price?.orZero() ?? ZERO,
      this?.activities?.map((activity) => activity.toDomain()).toList() ?? <Activity>[],
    );
  }
}

extension FestivalResponseMapper on FestivalResponse? {
  Festival toDomain() {
    return Festival(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
      this?.img?.orEmpty() ?? EMPTY,
      this?.description?.orEmpty() ?? EMPTY,
      this?.location != null? this!.location.toDomain(): DEFAULT_LOCATION,
      this?.people?.orZero() ?? ZERO,
      this?.activities?.map((activity) => activity.toDomain()).toList() ?? <Activity>[],
    );
  }
}

extension EmotionResponseMapper on EmotionResponse? {
  Emotion toDomain() {
    return Emotion(
      this?.img?.orEmpty() ?? EMPTY,
      this?.place?.toDomain(),
      this?.festival?.toDomain(),
      this?.activity?.toDomain(),
    );
  }
}

extension LocationResponseMapper on LocationResponse? {
  Location toDomain() {
    return Location(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
    );
  }
}

extension ActivityResponseMapper on ActivityResponse? {
  Activity toDomain() {
    return Activity(
      this?.id?.orZero() ?? ZERO,
      this?.name?.orEmpty() ?? EMPTY,
      this?.img?.orEmpty() ?? EMPTY,
    );
  }
}

extension UserFestivalResponseMapper on UserFestivalResponse? {
  List<Festival> toDomain() {
    return this?.festivals?.map((festival) => festival.toDomain()).toList() ?? <Festival>[];
  }
}

extension UserPlaceResponseMapper on UserPlaceResponse? {
  List<Place> toDomain() {
    return this?.places?.map((place) => place.toDomain()).toList() ?? <Place>[];
  }
}

extension BookingsResponseMapper on BookingsResponse? {
  List<Booking> toDomain() {
    return this?.bookings?.map((booking) => booking.toDomain()).toList() ?? <Booking>[];
  }
}

extension BookingResponseMapper on BookingResponse? {
  Booking toDomain() {
    return Booking(
      this?.id?.orZero() ?? ZERO,
      this?.places?.map((place) => place.toDomain()).toList() ?? <Place>[],
      this?.festivals?.map((festival) => festival.toDomain()).toList() ?? <Festival>[],
      this?.activities?.map((activity) => activity.toDomain()).toList() ?? <Activity>[],
    );
  }
}