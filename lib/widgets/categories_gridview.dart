import 'package:fix_flex/components/categories_card.dart';
import 'package:flutter/material.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesGridview extends StatelessWidget {
  CategoriesGridview({super.key});

  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state is LoadingIndicatorInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NoCategoriesState) {
          return Center(child: Text('No Categories'));
        } else if (state is CategoriesLoadedState) {
          return BuildCategoriesGrid(
            categoriesGridViewHeight: 245,
            categoriesItemCount: 6,
            builderIndex: 0,
          );
        } else if (state is ButtonIsClicked) {
          return BuildCategoriesGrid(
            categoriesGridViewHeight: 245,
            categoriesItemCount: 6,
            builderIndex: 0,
          );
        } else if (state is ResetButtonStates) {
          return BuildCategoriesGrid(
            categoriesGridViewHeight: 245,
            categoriesItemCount: 6,
            builderIndex: 0,
          );
        } else {
          return Center(child: BuildError());
        }
      },
    );
  }
}

class BuildCategoriesGrid extends StatelessWidget {
  const BuildCategoriesGrid({
    super.key,
    required this.categoriesGridViewHeight,
    required this.categoriesItemCount,
    required this.builderIndex,
  });
  final double categoriesGridViewHeight;
  final int categoriesItemCount;
  final int builderIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: categoriesGridViewHeight,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: categoriesItemCount,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryModel: GetCategoriesCubit.get(context)
                .categoriesDataList[index + builderIndex],
            index: index + builderIndex,
          );
        },
      ),
    );
  }
}

Column BuildError() {
  return Column(
    children: [
      Icon(
        Icons.error,
        color: Colors.red,
        size: 50,
      ),
      Text(
        'Failed to Load Categories \n please try again later',
        style: TextStyle(
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
