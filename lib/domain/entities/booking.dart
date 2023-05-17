// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';

class Booking {
  int client_id;
  List<Place> places;
  List<Festival> festivals;
  List<Activity> activities;
  Booking(
    this.client_id,
    this.places,
    this.festivals,
    this.activities,
  );

  Booking copyWith({
    int? client_id,
    List<Place>? places,
    List<Festival>? festivals,
    List<Activity>? activities,
  }) {
    return Booking(
      client_id ?? this.client_id,
      places ?? this.places,
      festivals ?? this.festivals,
      activities ?? this.activities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client_id': client_id,
      'places': places.map((x) => x.toMap()).toList(),
      'festivals': festivals.map((x) => x.toMap()).toList(),
      'activities': activities.map((x) => x.toMap()).toList(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      map['client_id'] as int,
      List<Place>.from((map['places'] as List<dynamic>).map<Place>((x) => Place.fromMap(x as Map<String,dynamic>),),),
      List<Festival>.from((map['festivals'] as List<dynamic>).map<Festival>((x) => Festival.fromMap(x as Map<String,dynamic>),),),
      List<Activity>.from((map['activities'] as List<dynamic>).map<Activity>((x) => Activity.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) => Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booking(client_id: $client_id, places: $places, festivals: $festivals, activities: $activities)';
  }

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;
  
    return 
      other.client_id == client_id &&
      listEquals(other.places, places) &&
      listEquals(other.festivals, festivals) &&
      listEquals(other.activities, activities);
  }

  @override
  int get hashCode {
    return client_id.hashCode ^
      places.hashCode ^
      festivals.hashCode ^
      activities.hashCode;
  }
}
