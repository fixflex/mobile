import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({
    super.key,
    this.imageLink,
    this.closeIcon,
    this.fileImage,
    this.filePath,
  });
  final String? imageLink;
  final Widget? closeIcon;
  final bool? fileImage;
  final File? filePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10), // Image border
          child: SizedBox.fromSize(
            size: Size.infinite, // Image radius
            child: fileImage ==true ? Image.file(filePath!,fit: BoxFit.cover) :Image.network(imageLink!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
            right: -10,
            top: -10,
            child: closeIcon !=null?closeIcon! : Container()),
      ],
    );
  }
}
