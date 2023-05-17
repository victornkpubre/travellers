// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';

class Emotion {
  final String img;
  final Place? place;
  final Festival? festival;
  final Activity? activity; 
  Emotion(
    this.img,
    this.place,
    this.festival,
    this.activity,
  );

  Emotion copyWith({
    String? img,
    Place? place,
    Festival? festival,
    Activity? activity,
  }) {
    return Emotion(
      img ?? this.img,
      place ?? this.place,
      festival ?? this.festival,
      activity ?? this.activity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'place': place?.toMap(),
      'festival': festival?.toMap(),
      'activity': activity?.toMap(),
    };
  }

  factory Emotion.fromMap(Map<String, dynamic> map) {
    return Emotion(
      map['img'] as String,
      map['place'] != null ? Place.fromMap(map['place'] as Map<String,dynamic>) : null,
      map['festival'] != null ? Festival.fromMap(map['festival'] as Map<String,dynamic>) : null,
      map['activity'] != null ? Activity.fromMap(map['activity'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Emotion.fromJson(String source) => Emotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Emotion(img: $img, place: $place, festival: $festival, activity: $activity)';
  }

  @override
  bool operator ==(covariant Emotion other) {
    if (identical(this, other)) return true;
  
    return 
      other.img == img &&
      other.place == place &&
      other.festival == festival &&
      other.activity == activity;
  }

  @override
  int get hashCode {
    return img.hashCode ^
      place.hashCode ^
      festival.hashCode ^
      activity.hashCode;
  }
}
