import 'package:fix_flex/components/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';

class MakeTaskRequestScreen extends StatelessWidget {
  const MakeTaskRequestScreen({super.key});

  static const String id = 'MakeTaskRequestScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostTaskCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Request A Task',
            style: TextStyle(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: BlocBuilder<PostTaskCubit, PostTaskState>(
                builder: (context, state) {
              var cubit = PostTaskCubit.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  //title TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    counterText: state is CounterTextChange
                        ? 'Minimum 10 characters'
                        : state is CounterMaxTextChange
                            ? 'Maximum 200 characters'
                            : null,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }else if(value.length < 10){
                        return 'Title must be at least 10 characters';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ), SizedBox(height: 20),
                  //details TFF
                  defaultFormField(
                    maxLength: 7000,
                    maxLines: 5,
                    width: double.infinity,
                    hint: 'details',

                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.detailsController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.padding,
                  ), SizedBox(height: 20),
                  //dueDate TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.dueDateController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ), SizedBox(height: 20),
                  //title TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ), SizedBox(height: 20),
                  //title TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ), SizedBox(height: 20),
                  //title TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ), SizedBox(height: 20),
                  //title TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ), SizedBox(height: 20),
                  //title TFF
                  defaultFormField(
                    maxLength: 200,
                    maxLines: 1,
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  ),
                ],
              );
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 60,
            child: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                'Post Task',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              backgroundColor: Color(0xff134161),
            ),
          ),
        ),
      ),
    );
    // Display selected image
  }
}

//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class MakeTaskRequestScreen extends StatefulWidget {
//   const MakeTaskRequestScreen({super.key});
//
//   static const String id = 'MakeTaskRequestScreen';
//
//   @override
//   State<MakeTaskRequestScreen> createState() => _TaskDetailsScreenState();
// }
//
// TextEditingController titleController = TextEditingController();
// TextEditingController descriptionController = TextEditingController();
// TextEditingController budgetController = TextEditingController();
// TextEditingController dateController = TextEditingController();
//
// DateTime _selectedDate = DateTime.now();
// File? _image;
//
// class _TaskDetailsScreenState extends State<MakeTaskRequestScreen> {
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData(
//             colorScheme: ColorScheme.light(
//               primary: Color(0xff134161),
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Color(0xff134161),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null)
//       setState(() {
//         dateController.text = picked.toString().split(" ")[0];
//       });
//   }
//
//   Future<void> _getImage() async {
//     final picker = ImagePicker();
//     try {
//       final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//       if (pickedImage != null) {
//         setState(() {
//           _image = File(pickedImage.path);
//         });
//       } else {
//         print('No image selected.');
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   void _clearImage() {
//     setState(() {
//       _image = null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Task Details',
//           style: TextStyle(color: Color(0xff134161)),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //TFF Title
//               TextFormField(
//                 controller: titleController,
//                 cursorColor: Color(0xff134161),
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                   labelStyle: TextStyle(color: Color(0xff134161)),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xff134161),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               //TFF Description
//               TextFormField(
//                 controller: descriptionController,
//                 cursorColor: Color(0xff134161),
//                 decoration: InputDecoration(
//                   labelText: 'Description',
//                   labelStyle: TextStyle(color: Color(0xff134161)),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xff134161),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               //TFF Budget
//               TextFormField(
//                 controller: budgetController,
//                 cursorColor: Color(0xff134161),
//                 decoration: InputDecoration(
//                   labelText: 'Budget',
//                   labelStyle: TextStyle(color: Color(0xff134161)),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xff134161),
//                     ),
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // TFF Deadline
//               TextFormField(
//                 controller: dateController,
//                 style: TextStyle(color: Color(0xff134161)),
//                 cursorColor: Color(0xff134161),
//                 decoration: InputDecoration(
//                   labelText: 'Deadline',
//                   labelStyle: TextStyle(color: Color(0xff134161)),
//                   prefixIcon: Icon(Icons.date_range),
//                   prefixIconColor: Color(0xff134161),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xff134161),
//                     ),
//                   ),
//                 ),
//                 readOnly: true,
//                 onTap: () => _selectDate(context),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // Display selected image
//               ElevatedButton.icon(
//                 onPressed: _getImage,
//                 icon: Icon(
//                   Icons.photo,
//                   color: Color(0xff134161),
//                 ),
//                 label: Text(
//                   'Upload Photo',
//                   style: TextStyle(color: Color(0xff134161)),
//                 ),
//               ),
//               // delete select image
//               if (_image != null) ...[
//                 Image.file(_image!),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _clearImage,
//                   child: Text('Delete Image',
//                       style: TextStyle(color: Color(0xff134161))),
//                 ),
//               ],
//               SizedBox(
//                 height: 50,
//               ),
//               // post offer
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Post Offer',
//                     style: TextStyle(color: Color(0xff134161))),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
