// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';


class PlacesTab extends StatelessWidget {
  List<Place> info;

  PlacesTab({
    Key? key,
    required this.info,
  }) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: info.length,
        itemBuilder: (BuildContext context, int index) {
          //TabView Images
          return GestureDetector(
            onTap: () {
              //Pass Place Obj 
              Navigator.pushNamed(context, Routes.placesRoute, arguments:  info[index].toMap());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 10),
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
              ),
              child: CachedNetworkImage (
                imageUrl: AppConstants.baseUrl+"/images/"+info[index].img,
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
