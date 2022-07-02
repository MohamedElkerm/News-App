import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/layout/cubit/cubit.dart';
import 'package:news_app_dio/layout/cubit/states.dart';
import 'package:news_app_dio/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder: (builder) {
            return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(list[index],context),
                separatorBuilder: (context, index) =>
                const Divider(thickness: 2.5),
              itemCount: NewsCubit.get(context).lenSports>20?20:NewsCubit.get(context).lenSports,);
          },
          fallback: (ctx) => const Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
