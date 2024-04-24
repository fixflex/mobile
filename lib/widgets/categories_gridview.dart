import 'package:fix_flex/widgets/categories_card.dart';
import 'package:flutter/material.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesGridview extends StatelessWidget {
  CategoriesGridview({super.key});

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetCategoriesCubit()..getCategories(),
      child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
        builder: (context, state) {
          if (state is LoadingIndicatorInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoCategoriesState) {
            return Center(child: Text('No Categories'));
          } else if (state is CategoriesLoadedState) {
            return BuildCategoriesGrid(state);
          }else if (state is ButtonIsClicked){
            return BuildCategoriesGrid(state);
          } else {
            return Center(child: BuildError());
          }
        },
      ),
    );
  }

  SizedBox BuildCategoriesGrid(state) {
    return SizedBox(
      height: 245,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        // itemCount: state.categories.length,
        itemCount: 6,
        itemBuilder: (context, index) {
          return CategoryCard(categoryModel: state.categories[index], index: index,);
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