import 'package:fix_flex/cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String id = 'category_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  GetCategoriesCubit.get(context).resetButtonStates();
                  Navigator.pop(context);
                },
              ),
              title: Text(GetCategoriesCubit.get(context).clickedCategoryId),
            ),
            body: Center(
              child: Text(GetCategoriesCubit.get(context)
                  .categoriesDataList[
                      GetCategoriesCubit.get(context).clickedCategoryIndex]
                  .name),
            ));
      },
    );
  }
}