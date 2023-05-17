import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/views/festivals/bloc/booking_bloc.dart';
import 'package:travellers/presentation/views/festivals/bloc/festivals_bloc.dart';

class FestivalView extends StatefulWidget {
  final festival;

  FestivalView({Key? key, required this.festival}) : super(key: key);

  @override
  State<FestivalView> createState() => _FestivalViewState();
}

class _FestivalViewState extends State<FestivalView> {
  late Festival festival;

  @override
  void initState() {
    super.initState();
    festival = Festival.fromMap(widget.festival);
    context.read<FestivalsBloc>().add(GetFavoriteFestival(festival: festival));
    context.read<FestivalBookingBloc>().add(GetBookingState(festival: festival));
  }

  @override
  Widget build(BuildContext context) {

    print("Festivals: " + festival.toString());

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        //Stack Widgets Requires horiontal and vertical bounds
        child: BlocListener<FestivalsBloc, FestivalsState>(
          listener: (context, state) {
            if(state is FestivalsError){
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
                          AppConstants.baseUrl + "/images/" + festival.img),
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
                              text: festival.name,
                              color: Colors.black.withOpacity(0.8)),
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
                                  text: festival.location.name + ", Nigeria",
                                  color: ColorManager.textColor1),
                            ],
                          ),
                          const SizedBox(height: 10),

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
                                color: festival.people == index
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: festival.people == index
                                    ? Colors.black
                                    : ColorManager.buttonBackground,
                                borderColor: festival.people == index
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
                              text: festival.description,
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
                    BlocBuilder<FestivalsBloc, FestivalsState>(
                      builder: (context, state) {
                        if(state is FestivalsLoading){
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        else {
                          return InkWell(
                            onTap: () {
                              (state is FestivalAdded)?
                              context.read<FestivalsBloc>().add(RemoveFavoriteFestival(festival: festival)):
                              context.read<FestivalsBloc>().add(AddFavoriteFestival(festival: festival));
                            },
                            child: AppButton(
                              color: (state is FestivalAdded)? Colors.white: ColorManager.textColor2,
                              backgroundColor: (state is FestivalAdded)? ColorManager.mainColor: Colors.white, 
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
                    BlocBuilder<FestivalBookingBloc, FestivalsState>(
                      builder: (context, state) {
                        return InkWell(
                            onTap: () {
                                context.read<FestivalBookingBloc>().add(BookingEvent(festival));
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
