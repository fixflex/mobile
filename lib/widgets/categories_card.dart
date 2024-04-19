import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../cubits/button_clicked_color_cubit/button_clicked_cubit.dart';
import '../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});

  final DataModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: BlocProvider(
                create: (context) => ButtonClickedCubit(),
                child: BlocBuilder<ButtonClickedCubit, ButtonClickedState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        ButtonClickedCubit.get(context).changeColor();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ButtonClickedCubit.get(context).boxColor,
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
                            color: ButtonClickedCubit.get(context).iconColor,
                          ),
                        ),
                      ),
                    );
                  },
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
