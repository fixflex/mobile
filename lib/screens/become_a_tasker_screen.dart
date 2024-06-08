import 'package:fix_flex/cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/models/category_model.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/make_an_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BecomeATaskerScreen extends StatelessWidget {
  const BecomeATaskerScreen({super.key});

  static const String id = 'BecomeATaskerScreen';

  @override
  Widget build(BuildContext context) {
    Future<bool> _popScope() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Discard Data?'),
          content: Text('Are you sure you want to discard this data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                MapCubit.get(context).resetLocationCubit(context);
                BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
    return WillPopScope(
      onWillPop: _popScope,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Become a Tasker'),
        ),
        body: BecomeATaskerBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingButton(),
      ),
    );
  }
}

class BecomeATaskerBody extends StatelessWidget {
  const BecomeATaskerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeATaskerCubit,BecomeATaskerState>(
      builder: (context,state) {
        if(state is BecomeATaskerSuccess) {
          CheckMyRoleCubit.get(context).checkMyRole();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
                builder: (context) {
                  Future.delayed(Duration(seconds: 2), () async {
                    Navigator.pop(context);
                    if(BecomeATaskerCubit.get(context).isTaskDetailsScreenOpen){
                      Navigator.pushReplacementNamed(context, MakeAnOfferScreen.id);
                    BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
                    }else{
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                    }
                  });
                  return PopScope(
                    canPop: false,
                    child: AlertDialog(
                      backgroundColor: Colors.white,
                      title: Icon(Icons.check_circle,color: Colors.green,size: 50,),
                      content: Text('You have successfully become a tasker.'),
                    ),
                  );}
            );
          }
          );
          MapCubit.get(context).resetLocationCubit(context);
        }else if(state is BecomeATaskerFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                  BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
                });
                return PopScope(
                canPop: false,
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  title: Icon(Icons.error,color: Colors.red,size: 50,),
                  content: Text('There was an error please try again later.'),
                ),
              );}
            );
          }
          );
        }
        return BlocConsumer<GetCategoriesCubit, GetCategoriesState>(
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
            if (state is GetLocationFromBecomeATaskerSuccess) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Icon(Icons.check_circle,color: Colors.green,size: 50,),
                  content: Text('Location captured successfully.'),
                );
              },);
            } else if (state is LocationServiceIsDisabled) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => PopScope(
                    canPop: false,
                    child: AlertDialog(
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
                  ),
                );
              });
            } else if (state is PermissionDenied &&
                state is! PermissionDeniedRestartTheApp) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => PopScope(
                    canPop: false,
                    child: AlertDialog(
                      backgroundColor: Colors.white,
                      title:
                          Text('Please give a permission to access your location.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Ok'),
                        )
                      ],
                    ),
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
                    title: Text('Permission denied please restart the app.'),
                  ),
                );
              });
            }
          }, builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  SelectCategoryDropDownMenu(),
                  CaptureLocationFromBecomeATasker(state: state, width: 300, height: 50,),
                ],
              ),
            );
          });
        });
      }
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
        padding: EdgeInsets.symmetric(vertical: 30),
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

class CaptureLocationFromBecomeATasker extends StatelessWidget {
  const CaptureLocationFromBecomeATasker({
    super.key,
    required this.state,
    required this.width,
    required this.height,
    this.shape,
  });
   final state;
   final double width;
    final double height;
    final MaterialStateProperty<OutlinedBorder?>? shape ;
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          height: height,
          child: OutlinedButton(
            style: ButtonStyle(
                backgroundColor: state is GetLocationFromBecomeATaskerSuccess
                    ? MaterialStateProperty.all(Color(0xff134161))
                    : MaterialStateProperty.all(Colors.grey),
              shape: shape,
            ),
            onPressed: () {
              MapCubit.get(context).state is MapLoading
                  ? null
                  :
              MapCubit.get(context).getCurrentLocationFromBecomeATasker(context);
            },
            child: state is MapLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          'Capture your location',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 60,
          child: FloatingActionButton(
            onPressed: () {
              BecomeATaskerCubit.get(context).state is BecomeATaskerLoading?null:
              SubmitErrorMessageCheck(state, context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: BlocBuilder<BecomeATaskerCubit,BecomeATaskerState>(
              builder: (context,state) {
                return state is BecomeATaskerLoading ?CircularProgressIndicator(color: Colors.white,):Text(
                  'Submit',
                  style:TextStyle(color: Colors.white, fontSize: 18),
                );
              }
            ),
            backgroundColor: state is GetLocationFromBecomeATaskerSuccess &&
                    BecomeATaskerCubit.get(context)
                        .CategoryController
                        .text
                        .isNotEmpty
                ? Color(0xff134161)
                : Colors.grey,
          ),
        ),
      );
    });
  }

  void SubmitErrorMessageCheck(MapState state, BuildContext context) {
    if (state is GetLocationFromBecomeATaskerSuccess &&
        BecomeATaskerCubit.get(context).CategoryController.text.isNotEmpty) {
      BecomeATaskerCubit.get(context).becomeATasker(state.position);
    } else if (BecomeATaskerCubit.get(context)
            .CategoryController
            .text
            .isEmpty &&
        state is! GetLocationFromBecomeATaskerSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a category and location'),
        backgroundColor: Colors.red,
      ));
    } else if (BecomeATaskerCubit.get(context)
            .CategoryController
            .text
            .isEmpty &&
        state is GetLocationFromBecomeATaskerSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a category'),
        backgroundColor: Colors.red,
      ));
    } else if (BecomeATaskerCubit.get(context)
            .CategoryController
            .text
            .isNotEmpty &&
        state is! GetLocationFromBecomeATaskerSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a location'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
