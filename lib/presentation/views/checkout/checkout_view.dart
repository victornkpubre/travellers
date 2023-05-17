import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'package:travellers/presentation/views/checkout/bloc/checkout_bloc.dart';


class CheckoutView extends StatefulWidget {
  final user;
  CheckoutView({super.key, required this.user});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = User.fromMap(widget.user);
    context.read<CheckoutBloc>().add(GetCheckout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutError) {
            //Display Toastbar
            showErrorToastbar(state.message);
          }
          if (state is CheckoutCompleted) {
            //Navigate to Home Screen
            showErrorToastbar("Booking placed successfully");
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
        },
        builder:(context, state) {
          if(state is CheckoutLoaded) {
            return _buildCheckoutView(state);
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

  _buildCheckoutView(CheckoutLoaded state) {
    print("Places in cart"+state.places.toString());
    print("Festivals in cart"+state.festivals.toString());
    print("Activities in cart"+state.activities.toString());
    
    List<Place>? placesInfo = state.places;
    List<Festival>? festivalsInfo = state.festivals;
    List<Activity>? activitiesInfo = state.activities; 
    
    return Stack (
      children: [
        
        //Main Panel
        Positioned (
          top: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration (
              color: Colors.white,
            ),
            child: (placesInfo!.isEmpty) && (festivalsInfo!.isEmpty) && (activitiesInfo!.isEmpty)? Container(
              height: double.infinity,
              child: Center(
                child: Text("You Havn't Made Any Bookings",
                textAlign: TextAlign.center,
                ),
              ),
            ): SingleChildScrollView(
              child: Column (
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2.5 / 7
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                      placesInfo.isNotEmpty? AppLargeText(
                        text: "Places",
                        size: 22,
                      ): Container(),
                      
                      placesInfo.isNotEmpty?ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1.5/5, maxWidth: MediaQuery.of(context).size.width*2/3),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: placesInfo.length,
                          itemBuilder:(context, index) {
                            
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () => Navigator.pushReplacementNamed(context, Routes.placesRoute, arguments:  placesInfo[index].toMap()),
                                child: GridTile(
                                  header: AppText(text: placesInfo[index].name, size: 16, color: Colors.white),
                                  footer: AppText(text: placesInfo[index].location.name, size: 12, color: Colors.white,),
                                  child: CachedNetworkImage (
                                    imageUrl: AppConstants.baseUrl+"/images/"+placesInfo[index].img,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: Icon(Icons.image)),
                                  ),
                                    
                                )
                              
                              ),
                            );
                          }, 
                        ),
                      ): Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*2/3),
                      ),
                      const SizedBox(height: 10),
            
                      festivalsInfo!.isNotEmpty? AppLargeText(
                        text: "Festivals",
                        size: 22,
                      ): Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*2/3),
                      ),
            
                      festivalsInfo.isNotEmpty?ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1.5/5, maxWidth: MediaQuery.of(context).size.width*2/3),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: festivalsInfo.length,
                          itemBuilder:(context, index) {
                            
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () => Navigator.pushReplacementNamed(context, Routes.placesRoute, arguments:  festivalsInfo[index].toMap()),
                                child: GridTile(
                                  header: AppText(text: festivalsInfo[index].name, size: 16, color: Colors.white),
                                  footer: AppText(text: festivalsInfo[index].location.name, size: 12, color: Colors.white,),
                                  child: CachedNetworkImage (
                                    imageUrl: AppConstants.baseUrl+"/images/"+festivalsInfo[index].img,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: Icon(Icons.image)),
                                  ),
                                    
                                )
                              
                              ),
                            );
                          }, 
                        ),
                      ): Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*2/3),
                      ),
                      const SizedBox(height: 10),
            
                      activitiesInfo!.isNotEmpty? AppLargeText(
                        text: "Activities",
                        size: 22,
                      ): Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*2/3),
                      ),
            
                      activitiesInfo.isNotEmpty?ConstrainedBox (
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1.5/5, maxWidth: MediaQuery.of(context).size.width*2/3),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemCount: activitiesInfo.length,
                          itemBuilder:(context, index) {
                            
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () => Navigator.pushReplacementNamed(context, Routes.placesRoute, arguments:  activitiesInfo[index].toMap()),
                                child: GridTile(
                                  child: CachedNetworkImage (
                                    imageUrl: AppConstants.baseUrl+"/images/"+activitiesInfo[index].img,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: Icon(Icons.image)),
                                  ),
                                )
                              ),
                            );
                          }, 
                        ),
                      ): Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*2/3),
                      ),
                      const SizedBox(height: 10),
                      
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),

        //Title Panel
        Positioned (
          top: 0,
          child: Container (
            padding: const EdgeInsets.only(left: 20, right: 30, top: 30),
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 1.2 / 6),
            decoration: BoxDecoration (
                color: ColorManager.mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.backspace,size: 30, color: Colors.white,),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.homeRoute);
                      },
                    ),

                    Column(
                      children: [
                        //Sub Heading (Title)
                        AppLargeText(
                          size: 26,
                          text: "N30,000",
                          color: Colors.white
                        ),
                        AppLargeText(
                          size: 24,
                          text: user.first_name+" "+user.last_name,
                          color: ColorManager.textColor1
                        ),
                      ],
                    ),

                  ],
                ),
  
              ],
            ),
          )
        ),

        //Checkout Icon
        Positioned (
          top: (MediaQuery.of(context).size.height * 2 / 9),
          width: MediaQuery.of(context).size.width,
          child: InkWell (
            onTap: () {
              context.read<CheckoutBloc>().add(PlaceBooking(user));
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: Container(
                
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.mainColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: AppLargeText(
                      text: "Confirm & Pay",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}

