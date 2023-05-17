import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  List images = ['welcome-one.png', 'welcome-two.png', 'welcome-three.png'];
  List titles = ['Tours', 'Trips', 'Travels'];
  List subtitles = ['Parks', 'Mountains', 'Lakes'];
  List descriptions = [
    "Activities like sightseeing, walking tours, hinking, canoeing create the perfect bonding experience",
    "Adventurous? lets hike up a hill, visit amusment parks, national parks, animal reserves",
    "A photographer's haven. Enjoy authentic scenery "
  ];
  int _currentPage = 0;
  late Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
void initState() {
  super.initState();
  _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  });
}

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/" + images[index]),
                        fit: BoxFit.cover)),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 150, 20, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(text: titles[index]),
                            AppText(text: subtitles[index]),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: AppSizes.getWidth(context)*3/5,
                              child: AppText(
                                text:
                                    descriptions[index],
                                color: ColorManager.textColor2,
                                size: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, Routes.homeRoute);
                              },
                              child: Container(
                                width: 200,
                                child: Row (
                                  children : [ 
                                    ResponsiveButton(text:"Skip", width: AppSizes.getWidth(context)*2/5,)
                                  ]
                                )
                              ),
                            )
                          ],
                        ),
                        Column(
                            children: List.generate(3, (indexDots) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: 8,
                            height: index == indexDots ? 25 : 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? ColorManager.mainColor
                                  : ColorManager.mainColor.withOpacity(0.3),
                            ),
                          );
                        })),
                      ]),
                ),
              );
            }));
  }
}
