// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/entities/emotion.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';

class EmotionsTab extends StatelessWidget {
  final List<Emotion> info;
  EmotionsTab({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        itemCount: info.length,
        itemBuilder: (context, index) {
          double height = (Random().nextInt(5)+2) * 50;
          return GestureDetector(
            onTap: () {
              //Navigate
              Navigator.pushNamed(context, Routes.emotionsRoute, arguments:  info[index].toMap());
            },
            child: Container (
              height: height,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: CachedNetworkImage(
                imageUrl: AppConstants.baseUrl+"/images/" +info[index].img,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: Text("Loading...")),
              ),
            ),
          );
        },
      ),
     
    );
  }
}
