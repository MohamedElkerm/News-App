import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_dio/layout/cubit/cubit.dart';
import 'package:news_app_dio/layout/cubit/states.dart';
import 'package:news_app_dio/layout/news_layout.dart';
import 'package:news_app_dio/shared/network/remote/dio_helper.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  //color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  //type!!!!!!!!!
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0),
              primarySwatch: Colors.deepOrange,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.grey,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.black45,
                  backgroundColor: HexColor('333739'),
                  elevation: 0),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).appMode,
            home: const Directionality(
              textDirection: TextDirection.rtl,
              child: NewsLayout(),
            ),
          );
        },
      ),
    );
  }
}
