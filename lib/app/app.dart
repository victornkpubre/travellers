
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellers/app/dependency_injector.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';


class MyApp extends StatefulWidget {
  //Singleton Pattern
  MyApp._internal();
  int appState = 0;
  static final MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DependencyInjector di;

  @override
  void initState() {
    super.initState();
    di = DependencyInjector();
    di.initPref();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: di.inject(),
      child: const MaterialApp (
        // theme: getApplicationTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashRoute,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
} 