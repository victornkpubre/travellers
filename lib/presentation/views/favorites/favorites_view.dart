
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'package:travellers/presentation/views/favorites/bloc/favorite_bloc.dart';

class FavoritesView extends StatefulWidget {
  final user;
  const FavoritesView({super.key, required this.user});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = User.fromMap(widget.user);
    context.read<FavoriteBloc>().add(GetFavoritesEvent(user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          
        },
        builder:(context, state) {
          if(state is FavoriteLoaded){
            print(state.places.toString());
            return _buildHomeView(state.places, state.festivals, context, user);
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

Widget _buildHomeView(List<Place> placesInfo, List<Festival> festivalsInfo, BuildContext context, User user) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width
        ),
        
        child: Stack(
          children: [

            Positioned(
              top: 0,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AppLargeText(text: "Favorites"),
                    AppText(text: user.first_name +" "+ user.last_name, color: ColorManager.mainColor,),
                    const SizedBox(height: 40),
                      
                    AppLargeText(
                      text: "Places",
                      size: 22,
                    ),
                      
                    ConstrainedBox (
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*1/3, maxWidth: MediaQuery.of(context).size.width),
                      child: ListView.builder(
                        itemCount: placesInfo.length,
                        itemBuilder:(context, index) {
                          print(placesInfo.toString());
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () => Navigator.pushReplacementNamed(context, Routes.placesRoute, arguments:  placesInfo[index].toMap()),
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  height: AppSize.s60,
                                  width: AppSize.s60,
                                  imageUrl: AppConstants.baseUrl+"/images/"+placesInfo[index].img,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: Icon(Icons.image)),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(text: placesInfo[index].name, size: 16, color: ColorManager.bigTextColor,),
                                    SizedBox(height: 5),
                                    AppText(text: placesInfo[index].location.name, size: 12,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                      
                    AppLargeText(
                      text: "Festivals",
                      size: 22,
                    ),
              
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height*1/3, 
                        maxWidth: MediaQuery.of(context).size.width
                      ),
                      child: ListView.builder(
                        itemCount: festivalsInfo.length,
                        itemBuilder:(context, index) {
                          print(festivalsInfo.toString());
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(

                              child: ListTile(
                                leading: CachedNetworkImage (
                                  height: AppSize.s60,
                                  width: AppSize.s60,
                                  imageUrl: AppConstants.baseUrl+"/images/"+festivalsInfo[index].img,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: Icon(Icons.image)),
                                ),
                                title: Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(text: festivalsInfo[index].name, size: 16, color: ColorManager.bigTextColor),
                                    SizedBox(height: 5),
                                    AppText(text: festivalsInfo[index].location.name, size: 12),
                                  ],
                                ),
                              ),
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
    );
  }