// import 'package:flutter/material.dart';
// class MakeTaskRequestScreen extends StatelessWidget {
//   const MakeTaskRequestScreen({super.key});
//
//   static const String id = 'MakeTaskRequestScreen';
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
//                 onTap: () {},
//               ),
//               SizedBox(
//                 height: 20,
//               )
//     ]))));
//               // Display selected image
//   }
// }



















import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MakeTaskRequestScreen extends StatefulWidget {
  const MakeTaskRequestScreen({super.key});

  static const String id = 'MakeTaskRequestScreen';

  @override
  State<MakeTaskRequestScreen> createState() => _TaskDetailsScreenState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController budgetController = TextEditingController();
TextEditingController dateController = TextEditingController();

DateTime _selectedDate = DateTime.now();
File? _image;

class _TaskDetailsScreenState extends State<MakeTaskRequestScreen> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0xff134161),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xff134161),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null)
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: TextStyle(color: Color(0xff134161)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TFF Title
              TextFormField(
                controller: titleController,
                cursorColor: Color(0xff134161),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color(0xff134161)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff134161),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //TFF Description
              TextFormField(
                controller: descriptionController,
                cursorColor: Color(0xff134161),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Color(0xff134161)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff134161),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //TFF Budget
              TextFormField(
                controller: budgetController,
                cursorColor: Color(0xff134161),
                decoration: InputDecoration(
                  labelText: 'Budget',
                  labelStyle: TextStyle(color: Color(0xff134161)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff134161),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              // TFF Deadline
              TextFormField(
                controller: dateController,
                style: TextStyle(color: Color(0xff134161)),
                cursorColor: Color(0xff134161),
                decoration: InputDecoration(
                  labelText: 'Deadline',
                  labelStyle: TextStyle(color: Color(0xff134161)),
                  prefixIcon: Icon(Icons.date_range),
                  prefixIconColor: Color(0xff134161),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff134161),
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              SizedBox(
                height: 20,
              ),
              // Display selected image
              ElevatedButton.icon(
                onPressed: _getImage,
                icon: Icon(
                  Icons.photo,
                  color: Color(0xff134161),
                ),
                label: Text(
                  'Upload Photo',
                  style: TextStyle(color: Color(0xff134161)),
                ),
              ),
              // delete select image
              if (_image != null) ...[
                Image.file(_image!),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _clearImage,
                  child: Text('Delete Image',
                      style: TextStyle(color: Color(0xff134161))),
                ),
              ],
              SizedBox(
                height: 50,
              ),
              // post offer
              ElevatedButton(
                onPressed: () {},
                child: Text('Post Offer',
                    style: TextStyle(color: Color(0xff134161))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
