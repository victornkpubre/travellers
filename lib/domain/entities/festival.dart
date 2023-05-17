// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/location.dart';

class Festival {
  int id;
  String name;
  String img;
  String description;
  Location location;
  int people;
  List<Activity>? activities;


  Festival(
    this.id,
    this.name,
    this.img,
    this.description,
    this.location,
    this.people,
    this.activities,
  );



  Festival copyWith({
    int? id,
    String? name,
    String? img,
    String? description,
    Location? location,
    int? people,
    List<Activity>? activities,
  }) {
    return Festival(
      id ?? this.id,
      name ?? this.name,
      img ?? this.img,
      description ?? this.description,
      location ?? this.location,
      people ?? this.people,
      activities ?? this.activities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'description': description,
      'location': location.toMap(),
      'people': people,
      'activities': activities?.map((x) => x.toMap()).toList(),
    };
  }

  factory Festival.fromMap(Map<String, dynamic> map) {
    return Festival(
      map['id'] as int,
      map['name'] as String,
      map['img'] as String,
      map['description'] as String,
      Location.fromMap(map['location'] as Map<String,dynamic>),
      map['people'] as int,
      map['activities'] != null ? List<Activity>.from((map['activities'] as List<dynamic>).map<Activity?>((x) => Activity.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Festival.fromJson(String source) => Festival.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Festival(id: $id, name: $name, img: $img, description: $description, location: $location, people: $people, activities: $activities)';
  }

  @override
  bool operator ==(covariant Festival other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.img == img &&
      other.description == description &&
      other.location == location &&
      other.people == people &&
      listEquals(other.activities, activities);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      img.hashCode ^
      description.hashCode ^
      location.hashCode ^
      people.hashCode ^
      activities.hashCode;
  }
}
