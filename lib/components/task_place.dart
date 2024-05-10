import 'package:fix_flex/components/add_task_photos.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/place_radio_button_cubit/place_radio_button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubits/map_cubit/map_cubit.dart';
import '../screens/post_a_task_screen.dart';

class TaskPlace extends StatelessWidget {
  const TaskPlace({super.key});

  static const String id = 'TaskPlace';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Place of Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Builder(builder: (context) {
          return BlocBuilder<PlaceRadioButtonCubit, PlaceRadioButtonState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('Say Where',
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                      color: Color(0xff134161),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Text('Where do you need it done?',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15,
                        ))),
                //location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    PlaceCustomRadioButtons(
                        index: 1,
                        icon: Icons.home,
                        title: 'In Person',
                        onPressed: () {
                          PlaceRadioButtonCubit.get(context).inPerson(1);
                        },
                        context: context),
                    Spacer(
                      flex: 2,
                    ),
                    PlaceCustomRadioButtons(
                        index: 2,
                        icon: Icons.laptop,
                        title: 'Online',
                        onPressed: () {
                          PlaceRadioButtonCubit.get(context).online(2);
                        },
                        context: context),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                state is InPersonSelected && state.selected == 1
                    ? BlocConsumer<MapCubit, MapState>(
                        listener: (context, state) {
                        if (state is GetLocationFromBecomeATaskerSuccess) {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.check_circle,color: Colors.green,size: 50,),
                              content: Text('Location captured successfully.'),
                            );
                          },);                        } else if (state is LocationServiceIsDisabled) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => PopScope(
                                canPop: false,
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  title:
                                      Text('Please activate location service.'),
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
                        return CaptureLocationFromPostATask(
                          state: state,
                          width: double.infinity,
                          height: 50,
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      })
                    : SizedBox(),
                Spacer(
                  flex: 6,
                ),
              ],
            );
          });
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<MapCubit, MapState>(builder: (context, state) {
        return BlocBuilder<PlaceRadioButtonCubit, PlaceRadioButtonState>(
            builder: (context, state) {
          return FloatingActionButtonInPostATask(
            backgroundColor: state is InPersonSelected &&
                        MapCubit.get(context).state
                            is GetLocationFromPostATaskSuccess ||
                    state is OnlineSelected
                ? kPrimaryColor
                : Colors.grey,
            text: 'Continue',
            onPressed: () {
              state is InPersonSelected &&
                          MapCubit.get(context).state
                              is GetLocationFromPostATaskSuccess ||
                      state is OnlineSelected
                  ? Navigator.pushNamed(context, AddTaskPhotos.id)
                  : null;
            },
          );
        });
      }),
    );
  }
}

Widget PlaceCustomRadioButtons({
  required int index,
  required String title,
  required void Function() onPressed,
  required BuildContext context,
  required icon,
}) {
  return BlocBuilder<PlaceRadioButtonCubit, PlaceRadioButtonState>(
      builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 150,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: state is InPersonSelected && state.selected == index ||
                        state is OnlineSelected && state.selected == index
                    ? Colors.white
                    : Color(0xff134161),
                size: 50,
              ),
              Text(
                title,
                style: TextStyle(
                  color: state is InPersonSelected && state.selected == index ||
                          state is OnlineSelected && state.selected == index
                      ? Colors.white
                      : Color(0xff134161),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                state is InPersonSelected && state.selected == index ||
                        state is OnlineSelected && state.selected == index
                    ? MaterialStateProperty.all(Color(0xff134161))
                    : MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  });
}

class CaptureLocationFromPostATask extends StatelessWidget {
  const CaptureLocationFromPostATask({
    super.key,
    required this.state,
    required this.width,
    required this.height,
    this.shape,
  });
  final state;
  final double width;
  final double height;
  final MaterialStateProperty<OutlinedBorder?>? shape;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: state is GetLocationFromPostATaskSuccess
                ? MaterialStateProperty.all(Color(0xff134161))
                : MaterialStateProperty.all(Colors.grey),
            shape: shape,
          ),
          onPressed: () {
            MapCubit.get(context).state is MapLoading
                ? null
                : MapCubit.get(context)
                    .getCurrentLocationFromPostATask(context);
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
