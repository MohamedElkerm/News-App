import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:news_app_dio/modules/bus/bus_screen.dart';
import 'package:news_app_dio/modules/science/science_screen.dart';
import 'package:news_app_dio/modules/settings_screen/settings_screen.dart';
import 'package:news_app_dio/modules/sports/sports_screen.dart';
import 'package:news_app_dio/shared/components/constants.dart';
import 'package:news_app_dio/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.business), label: 'التجاره'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'الرياضه'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'العلوم'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNaveBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();

    if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  int lenBusiness = 0;
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: method, query: queryBusiness).then((value) {
        //print(value!.data['totalResults']);
        business = value.data['articles'];
        lenBusiness = value.data['totalResults'];
        //print(business.length);
        emit(NewsGetBusinessSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(NewsGetBusinessErrorState(err.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];
  int lenSports = 0;
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: method, query: querySports).then((value) {
        //print(value!.data['totalResults']);
        sports = value.data['articles'];
        lenSports = value.data['totalResults'];
        //print(sports.length);
        emit(NewsGetSportsSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(NewsGetSportsErrorState(err.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  int lenScience = 0;
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: method, query: queryScience).then((value) {
        //print(value!.data['totalResults']);
        science = value.data['articles'];
        lenScience = value.data['totalResults'];
        print(lenScience);
        //print(sports.length);
        emit(NewsGetScienceSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(NewsGetScienceErrorState(err.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;
  ThemeMode appMode = ThemeMode.light;
  void changeAppMode() {
    isDark = !isDark;
    appMode = isDark?ThemeMode.dark:ThemeMode.light;
    emit(AppChangeModeState());
  }
}
