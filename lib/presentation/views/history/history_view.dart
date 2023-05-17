
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'package:travellers/presentation/views/favorites/bloc/favorite_bloc.dart';
import 'package:travellers/presentation/views/history/bloc/history_bloc.dart';

class HistoryView extends StatefulWidget {
  final user;
  const HistoryView({super.key, required this.user});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = User.fromMap(widget.user);
    context.read<HistoryBloc>().add(GetHistory(user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder:(context, state) {
          if(state is HistoryLoaded){
            return _buildHomeView(state.bookings, context, user);
          }
          else {
            return Container (
              child: Center (
                child: CircularProgressIndicator(),
              ),
            );
          }
        }, 
      ),
    );
  }
}

Widget _buildHomeView(List<Booking> bookings, BuildContext context, User user) {
  return Container(
    child: Container(
      // color: Colors.yellow,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width
        ),
        
        child: Stack(
          children: [

            Positioned(
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AppLargeText(text: "History"),
                    AppText(text: user.first_name +" "+ user.last_name, color: ColorManager.mainColor,),
                    const SizedBox(height: 40),
                      
                    ConstrainedBox (
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width-40),
                      child: ListView.builder(
                        itemCount: bookings.length,
                        itemBuilder:(context, index) {
                          Booking booking = bookings[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  color: ColorManager.mainColor,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // AppText(text:booking.client_id.toString()),
                                        AppText(text: "N"+_getTotal(booking).toString(), size: 16, color: Colors.white),
                                      ],
                                    ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: AppSize.s80,
                                      width: AppSize.s80,
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          height: AppSize.s80,
                                          autoPlay: true,
                                          viewportFraction: 1
                                        ),
                                        items: _getImages(booking).map((imageUrl) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return CachedNetworkImage(
                                                height: AppSize.s60,
                                                width: AppSize.s60,
                                                imageUrl: imageUrl,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => Center(child: Icon(Icons.image)),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        booking.places.isNotEmpty? AppText(text: "Places:"+ booking.places.length.toString()): Container(),
                                        booking.festivals.isNotEmpty? AppText(text: "Festivals:"+ booking.places.length.toString()): Container(),
                                        booking.activities.isNotEmpty? AppText(text: "Activities:"+ booking.places.length.toString()): Container()
                                      ]
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                
                  ],
                ),
              ),
            ),

            //Heading
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.backspace,
                      size: 30,
                      color: ColorManager.mainColor,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.homeRoute);
                    },
                  )
                ],
              ),
            ),
        
          ],
        ),
      ),
    ),
  );
}

double _getTotal(Booking booking){
  return booking.places.fold(0, (previousValue, element) => previousValue + element.price) + AppConstants.bookingCost;
}

List<String> _getImages(Booking booking){
  List<String> images = [];
  booking.places.forEach((element) {
    images.add(AppConstants.baseUrl+"/images/"+element.img);
  });
  booking.festivals.forEach((element) {
    images.add(AppConstants.baseUrl+"/images/"+element.img);
  });
  booking.activities.forEach((element) {
    images.add(AppConstants.baseUrl+"/images/"+element.img);
  });
  return images;
}