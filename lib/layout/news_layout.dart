import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/layout/cubit/cubit.dart';
import 'package:news_app_dio/layout/cubit/states.dart';
import 'package:news_app_dio/shared/components/constants.dart';
import 'package:news_app_dio/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('اهم الاخبار'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon:cubit.isDark?Icon(Icons.brightness_high_outlined) :Icon(Icons.dark_mode_rounded),
                onPressed: () {
                  cubit.changeAppMode();
                  print(cubit.isDark);
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNaveBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
