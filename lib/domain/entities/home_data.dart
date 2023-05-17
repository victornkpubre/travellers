// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/emotion.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';

class HomeDataObject {
  List<Place> places;
  List<Festival> festivals;
  List<Emotion> emotions;
  List<Activity> activities;
  HomeDataObject(
    this.places,
    this.festivals,
    this.emotions,
    this.activities,
  );


} 
