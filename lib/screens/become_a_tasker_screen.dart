import 'package:fix_flex/cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_screen.dart';

class BecomeATaskerScreen extends StatelessWidget {
  const BecomeATaskerScreen({super.key});

  static const String id = 'BecomeATaskerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Become a Tasker'),
      ),
      body: BlocConsumer<GetCategoriesCubit, GetCategoriesState>(
          listener: (context, state) {
        if (state is LoadingIndicatorInitial) {
          CircularProgressIndicator();
        } else if (state is CategoriesErrorState) {
          SnackBar(content: Text('Error loading categories'));
        } else if (state is NoCategoriesState) {
          SnackBar(content: Text('No categories found'));
        } else if (state is CategoriesLoadedState) {}
      }, builder: (context, state) {
        return BlocConsumer<MapCubit, MapState>(listener: (context, state) {
          if (state is GetLocationSuccess) {
            Navigator.pushNamed(context, MapScreen.id);
          }  else if (state is LocationServiceIsDisabled) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text('Please activate location service.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'),
                    )
                  ],
                ),
              );
            });
          } else if (state is PermissionDenied && state is !PermissionDeniedRestartTheApp) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                      'Please give a permission to access your location.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'),
                    )
                  ],
                ),
              );
            });
          } else if (state is PermissionDeniedRestartTheApp) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                      'Permission denied please restart the app.'),
                ),
              );
            });
          }
        }, builder: (context, state) {
          if (state is MapLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectCategoryDropDownMenu(),
                  ElevatedButton(
                    onPressed: () {
                      MapCubit.get(context).getCurrentLocation(context);
                    },
                    child: Text('mab'),
                  ),
                ],
              ),
            ],
          );
        });
      }),
    );
  }
}

class SelectCategoryDropDownMenu extends StatelessWidget {
  const SelectCategoryDropDownMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: DropdownButtonFormField(
        padding: EdgeInsets.all(5),
        onChanged: (String? newValue) {
          BecomeATaskerCubit.get(context).CategoryController.text = newValue!;
        },
        items: GetCategoriesCubit.get(context)
            .categoriesDataListWithoutMore
            .map<DropdownMenuItem<String>>((CategoryModel item) {
          return DropdownMenuItem<String>(
            value: item.id,
            child: Text(item.name),
          );
        }).toList(),
        isDense: true,
        isExpanded: true,
        decoration: InputDecoration(
          isDense: true,
          alignLabelWithHint: true,
          constraints: BoxConstraints.tightFor(width: 50),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: 'Select category',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.black)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
