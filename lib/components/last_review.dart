// import 'package:fix_flex/components/add_task_photos.dart';
// import 'package:fix_flex/components/choose_time_of_task.dart';
// import 'package:fix_flex/components/select_a_budget.dart';
// import 'package:fix_flex/components/task_place.dart';
// import 'package:fix_flex/cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
// import 'package:fix_flex/cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
// import 'package:fix_flex/screens/task_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../screens/post_a_task_screen.dart';
//
// class LastReview extends StatelessWidget {
//   const LastReview({super.key});
//
//   static const String id = 'LastReview';
//
//
//   @override
//   Widget build(BuildContext context) {
//     Map<String,ListTileWidget> listTileDataMap ={
//       'Title': ListTileWidget(icons: Icons.title, title: PostTaskCubit.get(context).titleController.text,onTap: (){Navigator.pushNamed(context, PostATaskScreen.id);},),
//       'Date': ListTileWidget(icons: Icons.calendar_month, title: '',onTap: () {Navigator.pushNamed(context, ChooseTimeOfTask.id);},),
//       'Location': ListTileWidget(icons: Icons.location_on, title: '',onTap: () {Navigator.pushNamed(context, TaskPlace.id);},),
//       'Images': ListTileWidget(icons: Icons.camera_alt_outlined, title: 'Images',onTap: () {Navigator.pushNamed(context, AddTaskPhotos.id);},),
//       'Budget': ListTileWidget(icons: Icons.attach_money, title: BudgetCubit.get(context).budgetController.text,onTap: () {Navigator.pushNamed(context, SelectABudget.id);},),
//
//     };
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Last Review'),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Alright, Ready to get offers?',
//                 style: GoogleFonts.abel(
//                     textStyle: TextStyle(
//                       color: Color(0xff134161),
//                       fontSize: 35,
//                       fontWeight: FontWeight.bold,
//                     ))),
//             Padding(
//                 padding: const EdgeInsets.only(left: 10, bottom: 25),
//                 child:
//                 Text('Post the task when you\'re ready',
//                     style: TextStyle(
//                       color: Colors.grey[500],
//                       fontSize: 15,
//                     ))),
//
//             SizedBox(
//               height: 360,
//               child: ListView.separated(
//                 separatorBuilder: (context, index) => Divider(
//                   color: Colors.grey[300],
//                 ),
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                 return listTileDataMap.values.elementAt(index);
//               },
//               itemCount: 5,
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButtonInPostATask(
//         text: 'Continue',
//         onPressed: () {
//           // Navigator.pushNamed(context, .id);
//         },
//       ),
//     );
//   }
// }
//
// class ListTileWidget extends StatelessWidget {
//   const ListTileWidget({
//     super.key,
//     required this.icons,
//     required this.title,
//     required this.onTap,
//   });
//   final IconData icons;
//   final String title;
//   final void Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onTap,
//       contentPadding: EdgeInsets.all(0),
//       leading: Icon(icons, color: Colors.grey,size: 30,),
//       title: Text(
//           title,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 25,
//             fontWeight: FontWeight.w400,
//           )),
//       trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey,size: 25,),
//     );
//   }
// }
