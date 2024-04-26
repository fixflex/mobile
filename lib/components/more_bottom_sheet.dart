import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import '../widgets/categories_gridview.dart';

void MoreBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BlocBuilder<GetCategoriesCubit,GetCategoriesState>(
        builder:(context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 15),
                  BuildCategoriesGrid(
                    categoriesGridViewHeight:400,
                    categoriesItemCount:
                    GetCategoriesCubit.get(context).categoriesDataList.length - 6,
                    builderIndex: 6,
                  ),
                ],
              ),
            ),
          );
        },

      );
    },
  ).whenComplete(() {
    GetCategoriesCubit.get(context).resetButtonStates();
  },);
}