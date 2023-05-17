import 'package:flutter/material.dart';
import 'package:travellers/presentation/views/pages.dart';
import 'package:travellers/presentation/resources/string_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
  static const String placesRoute = "/places";
  static const String festivalsRoute = "/festivals";
  static const String emotionsRoute = "/emotions";
  static const String profileRoute = "/profile";
  static const String checkoutRoute = "/checkout";
  static const String favoritesRoute = "/favorites";
  static const String historyRoute = "/history";
}


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case (Routes.splashRoute):
        return MaterialPageRoute(builder: ((context) => SplashView()));

      case (Routes.loginRoute):
        return MaterialPageRoute(builder: ((context) => LoginView()));

      case (Routes.registerRoute):
        return MaterialPageRoute(builder: ((context) => RegisterView()));

      case (Routes.onBoardingRoute):
        return MaterialPageRoute(builder: ((context) => OnboardingView()));

      case (Routes.homeRoute):
        return getPageSlashPageTransition(routeSettings);

      case (Routes.placesRoute):
        return MaterialPageRoute(builder: ((context) => PlaceView(place: routeSettings.arguments)));
      
      case (Routes.festivalsRoute):
        return MaterialPageRoute(builder: ((context) => FestivalView(festival: routeSettings.arguments)));

      case (Routes.emotionsRoute):
        return MaterialPageRoute(builder: ((context) => EmotionView(emotion: routeSettings.arguments)));
      
      case (Routes.profileRoute):
        return MaterialPageRoute(builder: ((context) => ProfileView(user: routeSettings.arguments)));

      case (Routes.favoritesRoute):
        return MaterialPageRoute(builder: ((context) => FavoritesView(user: routeSettings.arguments)));

      case (Routes.historyRoute):
        return MaterialPageRoute(builder: ((context) => HistoryView(user: routeSettings.arguments)));
      
      case (Routes.checkoutRoute):
        return MaterialPageRoute(builder: ((context) => CheckoutView(user: routeSettings.arguments)));
      
      default:
        return unDefinedRoute();
    }
  }

  static getPageSlashPageTransition(RouteSettings routeSettings) {
    return PageRouteBuilder(
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          alignment: Alignment.center,
          scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation (
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return getPage(routeSettings);
      },
    );
  }

  static getPageSimplePageTransition(RouteSettings routeSettings) {
    return PageRouteBuilder(
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>( begin: Offset(-1, 0), end: Offset(0, 0),).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return getPage(routeSettings);
      },
    );
  }

  static Widget getPage(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case (Routes.splashRoute):
        return SplashView();

      case (Routes.loginRoute):
        return LoginView();
      
      case (Routes.registerRoute):
        return RegisterView();

      case (Routes.onBoardingRoute):
        return OnboardingView();

      case (Routes.homeRoute):
        return HomeView();

      case (Routes.placesRoute):
        return PlaceView(place: routeSettings.arguments);
      
      case (Routes.festivalsRoute):
        return FestivalView(festival: routeSettings.arguments,);

      case (Routes.emotionsRoute):
        return EmotionView(emotion: routeSettings.arguments,);
      
      case (Routes.profileRoute):
        return ProfileView(user: routeSettings.arguments);

      case (Routes.favoritesRoute):
        return FavoritesView(user: routeSettings.arguments);

      case (Routes.historyRoute):
        return HistoryView(user: routeSettings.arguments);
      
      case (Routes.checkoutRoute):
        return CheckoutView(user: routeSettings.arguments);
      
      default:
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.noRouteFound),
          ),
          body: Center(child: Text(AppStrings.noRouteFound)),
        );
    }
  }
  
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(
      builder: ((_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound),
        ),
        body: Center(child: Text(AppStrings.noRouteFound)),
      ))
    );
  }

}

