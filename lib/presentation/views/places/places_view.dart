import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/presentation/views/places/bloc/booking_bloc.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'package:travellers/presentation/views/places/bloc/places_bloc.dart';

class PlaceView extends StatefulWidget {
  final place;

  PlaceView({Key? key, required this.place}) : super(key: key);

  @override
  State<PlaceView> createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  late Place place;

  @override
  void initState() {
    super.initState();
    place = Place.fromMap(widget.place);
    context.read<PlacesBloc>().add(GetFavoritePlace(place: place));
    context.read<PlaceBookingBloc>().add(GetBookingState(place: place));
  }

  @override
  Widget build(BuildContext context) {

    print("Places: " + place.toString());

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        //Stack Widgets Requires horiontal and vertical bounds
        child: BlocListener<PlacesBloc, PlacesState>(
          listener: (context, state) {
            if(state is PlacesError){
              showErrorToastbar(state.message);
            }
          },
          child: Stack(
                  children: [
                    //Banner Image
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 2 / 5,
                          child: PhotoView(
                            imageProvider: NetworkImage(
                                AppConstants.baseUrl + "/images/" + place.img),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,
                            initialScale: PhotoViewComputedScale.covered * 1.1,
                            basePosition: Alignment.center,
                          ),
                        )),
        
                    //Back Button
                    Positioned(
                      left: 20,
                      top: MediaQuery.of(context).size.height / 20,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.backspace,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, Routes.homeRoute);
                            },
                          )
                        ],
                      ),
                    ),
        
                    //Main Panel
                    Positioned(
                        top: MediaQuery.of(context).size.height * 2 / 5,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 3 / 5,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Sub Heading (Title and Price)
                                AppLargeText(
                                    size: 26,
                                    text: place.name,
                                    color: Colors.black.withOpacity(0.8)),
                                const SizedBox(height: 5),
                                AppLargeText(
                                    size: 20,
                                    text: "\$" + place.price.toString(),
                                    color: ColorManager.mainColor),
                                const SizedBox(height: 5),
        
                                //Location
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: ColorManager.mainColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AppText(
                                        text: place.location.name + ", Nigeria",
                                        color: ColorManager.textColor1),
                                  ],
                                ),
                                const SizedBox(height: 10),
        
                                //Stars
                                Row(
                                  children: [
                                    Wrap(
                                      children: List.generate(place.stars, (index) {
                                        return Icon(Icons.star,
                                            color: place.stars > index
                                                ? ColorManager.starColor
                                                : ColorManager.textColor2);
                                      }),
                                    ),
                                    const SizedBox(height: 10),
                                    AppText(
                                        text: "(" + place.stars.toString() + ".0)",
                                        color: ColorManager.textColor2)
                                  ],
                                ),
                                const SizedBox(height: 30),
        
                                //Group Details
                                AppLargeText(
                                  text: "People",
                                  color: Colors.black.withOpacity(0.8),
                                  size: 26,
                                ),
                                const SizedBox(height: 5),
        
                                AppText(
                                    text: "Number of people in a group",
                                    color: ColorManager.mainTextColor),
                                const SizedBox(height: 10),
        
                                Wrap(
                                  children: List.generate(5, (index) {
                                    return AppButton(
                                      size: 50,
                                      color: place.people == index
                                          ? Colors.white
                                          : Colors.black,
                                      backgroundColor: place.people == index
                                          ? Colors.black
                                          : ColorManager.buttonBackground,
                                      borderColor: place.people == index
                                          ? Colors.black
                                          : ColorManager.buttonBackground,
                                      text: (index + 1).toString(),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 30),
        
                                AppLargeText(
                                    size: 26,
                                    text: "Description",
                                    color: Colors.black.withOpacity(0.8)),
                                const SizedBox(height: 5),
                                AppText(
                                    text: place.description,
                                    color: ColorManager.mainTextColor),
        
                                const SizedBox(height: 200),
                              ],
                            ),
                          ),
                        )),
        
                    //Booking Section
                    Positioned(
                      bottom: 10,
                      left: 20,
                      right: 20,
                      child: Row(
                        children: [
                          //Favorite Button
                          BlocBuilder<PlacesBloc, PlacesState>(
                            builder: (context, state) {
                              if(state is PlacesLoading){
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              else {
                                return InkWell(
                                  onTap: () {
                                    (state is PlaceAdded)?
                                    context.read<PlacesBloc>().add(RemoveFavoritePlace(place: place)):
                                    context.read<PlacesBloc>().add(AddFavoritePlace(place: place));
                                  },
                                  child: AppButton(
                                    color: (state is PlaceAdded)? Colors.white: ColorManager.textColor2,
                                    backgroundColor: (state is PlaceAdded)? ColorManager.mainColor: Colors.white, 
                                    borderColor: ColorManager.textColor2,
                                    size: 60,
                                    icon: Icons.favorite
                                  )
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
        
                          //Booking Button
                          BlocBuilder<PlaceBookingBloc, PlacesState>(
                            builder: (context, state) {
                              return InkWell(
                                  onTap: () {
                                     context.read<PlaceBookingBloc>().add(BookingEvent(place));
                                  },
                                  child: ResponsiveButton(
                                    text: (state is RemovedFromBooking)? "Book Trip Now"
                                    :(state is AddedToBooking)?"Booked": 
                                    (state is BookingLoading)?"Booking":
                                    "Book Trip Now",
                                    isResponsive: false,
                                    width: MediaQuery.of(context).size.width* 3/5,
                                  ),
                                );
                              
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
