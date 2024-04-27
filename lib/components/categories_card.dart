import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'more_bottom_sheet.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import '../models/category_model.dart';
import '../screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.categoryModel, required this.index});

  final CategoryModel categoryModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    GetCategoriesCubit.get(context).handleButtonTap(index);
                    if (GetCategoriesCubit.get(context).clickedCategoryId ==
                        GetCategoriesCubit.get(context)
                            .categoriesDataList[5]
                            .id) {
                      MoreBottomSheet(context);
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => CategoryScreen()),
                          ModalRoute.withName(HomeScreen.id));
                      // Navigator.pushNamed(context, CategoryScreen.id);
                      await Future.delayed(Duration(milliseconds: 300));
                      GetCategoriesCubit.get(context).resetButtonStates();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: GetCategoriesCubit.get(context)
                              .buttonClickedStates[index]
                          ? Color(0xff134161)
                          : Colors.white,
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
                    child: categoryModel.image.imageUrl != null
                        ? Center(
                          child: SvgPicture.network(
                              categoryModel.image.imageUrl!,
                              width: 45,
                              height: 45,
                              color: GetCategoriesCubit.get(context)
                                      .buttonClickedStates[index]
                                  ? Colors.white
                                  : Color(0xff134161),
                            ),
                        )
                        : Center(child: SvgPicture.asset('assets/images/question-mark-svgrepo-com.svg',width: 45,height: 45, color: GetCategoriesCubit.get(context)
                        .buttonClickedStates[index]
                        ? Colors.white
                        : Color(0xff134161),)),
                    // child: Center(
                    //   child: SvgPicture.network(
                    //     categoryModel.image.imageUrl ?? '',
                    //     width: 45,
                    //     height: 45,
                    //     color: GetCategoriesCubit.get(context)
                    //             .buttonClickedStates[index]
                    //         ? Colors.white
                    //         : Color(0xff134161),
                    //   ),
                    // ),
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
      ),
    );
  }
}
