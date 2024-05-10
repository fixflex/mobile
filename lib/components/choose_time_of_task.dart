import 'package:fix_flex/components/task_place.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/date_radio_button_cubit/date_radio_button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../screens/post_a_task_screen.dart';

class ChooseTimeOfTask extends StatelessWidget {
  const ChooseTimeOfTask({super.key});

  static const String id = 'ChooseTimeOfTask';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Time of Task'),
      ),
      body: BlocBuilder<DateRadioButtonCubit,DateRadioButtonState>(
        builder: (context, state) {
          final cubit = DateRadioButtonCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('Decide On When',
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                      color: Color(0xff134161),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Text('When do you need this done?',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15,
                        ))),
                //dueDate
                DateCustomRadioButtons(
                  index: 1,
                  title: state is OnDateRadioButtonsSelected && state.onDateSelected !=null ?'On ${DateFormat.yMMMMd().format(DateTime(state.onDateSelected!.year,state.onDateSelected!.month,state.onDateSelected!.day))}':'On Date',
                  onPressed: () {
                    DateRadioButtonCubit.get(context).OnDateSelected(index: 1);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CalenderDialog(cubit: cubit,onSubmit: (p0) {
                            cubit.OnDateSelected(index: 1,date:p0 as DateTime);
                            Navigator.pop(context);

                          }, controller: cubit.onDatePickerController,);
                        });
                  },
                  context: context,
                ),
                DateCustomRadioButtons(
                  index: 2,
                  title: state is BeforeDateRadioButtonsSelected && state.beforeDateSelected !=null ?'Before ${DateFormat.yMMMMd().format(DateTime(state.beforeDateSelected!.year,state.beforeDateSelected!.month,state.beforeDateSelected!.day))}':'Before Date',
                  onPressed: () {
                    DateRadioButtonCubit.get(context).BeforeDateSelected(index: 2);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CalenderDialog(cubit: cubit,onSubmit: (p0) {
                            cubit.BeforeDateSelected(index: 2,date:p0 as DateTime);
                            Navigator.pop(context);
                          }, controller: cubit.beforeDatePickerController,);
                        });
                  },
                  context: context,
                ),
                DateCustomRadioButtons(
                  index: 3,
                  title: 'Flexible',
                  onPressed: () {
                    DateRadioButtonCubit.get(context).FlexibleDateSelected(index: 3);
                    // cubit.Flexible();
                  },
                  context: context,
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<DateRadioButtonCubit,DateRadioButtonState>(
        builder: (context, state) {
          return BlocBuilder<DateRadioButtonCubit,DateRadioButtonState>(
            builder: (context, state) {
              final cubit = DateRadioButtonCubit.get(context);
              return FloatingActionButtonInPostATask(
                backgroundColor: state is OnDateRadioButtonsSelected && cubit.onDateSelected !=null || state is BeforeDateRadioButtonsSelected && cubit.beforeDateSelected != null || state is FlexibleDateRadioButtonsSelected?
                kPrimaryColor: Colors.grey,
                text: 'Continue',
                onPressed: () {
                  state is OnDateRadioButtonsSelected && cubit.onDateSelected !=null || state is BeforeDateRadioButtonsSelected && cubit.beforeDateSelected != null || state is FlexibleDateRadioButtonsSelected?
                  Navigator.pushNamed(context, TaskPlace.id): null ;
                },
              );
            }
          );
        }
      ),
    );
  }
}

class CalenderDialog extends StatelessWidget {
  const CalenderDialog({
    super.key,
    required this.cubit,
    required this.onSubmit,
    required this.controller,
  });

  final DateRadioButtonCubit cubit;
  final dynamic Function(Object?)? onSubmit;
  final DateRangePickerController? controller;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:15, vertical:10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SfDateRangePicker(
              initialDisplayDate: DateTime.now(),
              initialSelectedDate: DateTime.now(),
              minDate: DateTime.now(),
              maxDate: DateTime.now().add(Duration(days: 365)),
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              yearCellStyle: DateRangePickerYearCellStyle(
                todayCellDecoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                disabledDatesTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                leadingDatesTextStyle: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
                textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                disabledDatesTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
              selectionTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              selectionMode:DateRangePickerSelectionMode.single,
              showActionButtons: true,
              controller: controller,
              onSubmit: onSubmit,
              onCancel: () {
                Navigator.pop(context);
              },
              showNavigationArrow: true,
              headerHeight: 80,
              selectionColor: kPrimaryColor,
              todayHighlightColor: kPrimaryColor,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}



// class CalenderDialog extends StatelessWidget {
//   const CalenderDialog({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: 300,
//         height: 400,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: SfDateRangePicker(
//             initialDisplayDate: DateTime.now(),
//             initialSelectedDate: DateTime.now(),
//             minDate: DateTime.now(),
//             maxDate: DateTime.now().add(Duration(days: 365)),
//             headerStyle: DateRangePickerHeaderStyle(
//               textAlign: TextAlign.center,
//               backgroundColor: kPrimaryColor,
//               textStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             yearCellStyle: DateRangePickerYearCellStyle(
//               todayCellDecoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: Colors.white,
//                 ),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               disabledDatesTextStyle: TextStyle(
//                 color: Colors.red,
//                 fontSize: 20,
//               ),
//               todayTextStyle: TextStyle(
//                 color: kPrimaryColor,
//                 fontSize: 20,
//               ),
//               leadingDatesTextStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//               textStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//             monthViewSettings: DateRangePickerMonthViewSettings(
//               viewHeaderStyle: DateRangePickerViewHeaderStyle(
//                 textStyle: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             monthCellStyle: DateRangePickerMonthCellStyle(
//               todayTextStyle: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 20,
//               ),
//               disabledDatesTextStyle: TextStyle(
//                 color: Colors.red,
//                 fontSize: 20,
//               ),
//               textStyle: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               ),
//             ),
//             selectionTextStyle: TextStyle(
//               color: kPrimaryColor,
//               fontSize: 20,
//             ),
//             selectionMode:DateRangePickerSelectionMode.single,
//             // showActionButtons: true,
//             showTodayButton: true,
//             showNavigationArrow: true,
//             headerHeight: 75,
//             selectionColor: Colors.white,
//             todayHighlightColor: Colors.grey,
//             backgroundColor: kPrimaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }



Widget DateCustomRadioButtons(
    {required int index,
    required String title,
    required void Function() onPressed,
    required BuildContext context}) {
  return BlocBuilder<DateRadioButtonCubit, DateRadioButtonState>(
      builder: (context, state) {
        final cubit = DateRadioButtonCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              color:
                  state is OnDateRadioButtonsSelected && state.selected == index && cubit.onDateSelected !=null || state is BeforeDateRadioButtonsSelected && state.selected == index && cubit.beforeDateSelected != null || state is FlexibleDateRadioButtonsSelected && state.selected == index
                      ? Colors.white
                      : Color(0xff134161),
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
            state is OnDateRadioButtonsSelected && state.selected == index && cubit.onDateSelected !=null || state is BeforeDateRadioButtonsSelected && state.selected == index && cubit.beforeDateSelected != null || state is FlexibleDateRadioButtonsSelected && state.selected == index
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