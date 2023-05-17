
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/entities/emotion.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/views/emotions/bloc/emotions_bloc.dart';

class EmotionView extends StatefulWidget {
  final emotion;
  EmotionView({Key? key, required this.emotion}) : super(key: key);

  @override
  State<EmotionView> createState() => _EmotionViewState();
}

class _EmotionViewState extends State<EmotionView> {
  late Emotion emotion;

  @override
  void initState() {
    super.initState();
    emotion = Emotion.fromMap(widget.emotion);
    context.read<EmotionsBloc>().add(GetBookingState(emotion));
  }

  @override
  Widget build(BuildContext context) {
    final Emotion emotion = Emotion.fromMap(widget.emotion);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        child: Stack(
          children: [

            //Banner Image
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 5/6,
                
                child: PhotoView(
                  imageProvider: NetworkImage(AppConstants.baseUrl + "/images/" + emotion.img),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1,
                  initialScale: PhotoViewComputedScale.covered,
                  basePosition: Alignment.center,
                ),
              )
            ),
    
            
            //Title Panel
            Positioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 30, top: 30),
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 1.2 / 6),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //Sub Heading (Title)
                      InkWell(
                        onTap: () {
                          
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: AppLargeText(
                            size: 26,
                            text: emotion.place?.name?? emotion.festival!.name,
                            color: Colors.black.withOpacity(0.8)
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      //Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: ColorManager.mainColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          AppText(
                            text:  emotion.place?.location.name?? emotion.festival!.location.name + ", Nigeria",
                            color: ColorManager.textColor1
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                  
                    ],
                  ),
                )
            ),


            //Back Button
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 1/ 12,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.backspace,size: 30, color: Colors.black,),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.homeRoute);
                    },
                  )
                ],
              ),
            ),


            //Activity Section
            emotion.activity!=null? Positioned(
              top: MediaQuery.of(context).size.width/2,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Favorite Button
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CachedNetworkImage (
                      imageUrl: "${AppConstants.baseUrl}/images/${emotion.activity!.img}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: Text("...")),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.mainColor,
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: AppText(text: emotion.activity!.name, color: Colors.white, size: 20,)
                      ),
                    ),
                  ),
                ],
              ),
            ): Container(),

            //Booking Section
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Row(
                children: [

                  //Booking Button
                  BlocBuilder<EmotionsBloc, EmotionsState>(
                    builder: (context, state) {
                      return InkWell(
                          onTap: () {
                              context.read<EmotionsBloc>().add(BookingEvent(emotion));
                          },
                          child: ResponsiveButton(
                            text: (state is RemovedFromBooking)? "Book Trip Now"
                            :(state is AddedToBooking)?"Booked": 
                            (state is EmotionLoading)?"Booking":
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
    );
  }
}