import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import '../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel, required this.index});

  final DataModel categoryModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  GetCategoriesCubit.get(context).handleButtonTap(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: GetCategoriesCubit.get(context).buttonClickedStates[index] ? Color(0xff134161) : Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        spreadRadius: 0.3,
                        offset: Offset(0.7, 0.7),
                      )
                    ],
                  ),
                  width: 80,
                  height: 80,
                  child: Center(
                    child: SvgPicture.network(
                      categoryModel.image.imageUrl!,
                      width: 45,
                      height: 45,
                      color: GetCategoriesCubit.get(context).buttonClickedStates[index] ? Colors.white : Color(0xff134161),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              categoryModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
