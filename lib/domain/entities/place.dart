// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/location.dart';

class Place {
  int id;
  String name;
  String img;
  String description;
  Location location;
  int stars;
  int people;
  int price;
  List<Activity>? activities;

  Place(
    this.id,
    this.name,
    this.img,
    this.description,
    this.location,
    this.stars,
    this.people,
    this.price,
    this.activities,
  );
 

  Place copyWith({
    int? id,
    String? name,
    String? img,
    String? description,
    Location? location,
    int? stars,
    int? people,
    int? price,
    List<Activity>? activities,
  }) {
    return Place(
      id ?? this.id,
      name ?? this.name,
      img ?? this.img,
      description ?? this.description,
      location ?? this.location,
      stars ?? this.stars,
      people ?? this.people,
      price ?? this.price,
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
      'stars': stars,
      'people': people,
      'price': price,
      'activities': activities?.map((x) => x.toMap()).toList(),
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      map['id'] as int,
      map['name'] as String,
      map['img'] as String,
      map['description'] as String,
      Location.fromMap(map['location'] as Map<String,dynamic>),
      map['stars'] as int,
      map['people'] as int,
      map['price'] as int,
      map['activities'] != null ? List<Activity>.from((map['activities'] as List<dynamic>).map<Activity?>((x) => Activity.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(id: $id, name: $name, img: $img, description: $description, location: $location, stars: $stars, people: $people, price: $price, activities: $activities)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.img == img &&
      other.description == description &&
      other.location == location &&
      other.stars == stars &&
      other.people == people &&
      other.price == price &&
      listEquals(other.activities, activities);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      img.hashCode ^
      description.hashCode ^
      location.hashCode ^
      stars.hashCode ^
      people.hashCode ^
      price.hashCode ^
      activities.hashCode;
  }
}
