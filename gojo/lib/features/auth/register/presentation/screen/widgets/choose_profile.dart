import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class ChooseProfilePic extends StatelessWidget {
  final String? path;

  const ChooseProfilePic({
    super.key,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: path == null
            ? Image.asset(Resources.gojoImages.headShot).image
            : Image.file(File(path!)).image,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.add_circle,
              color: Resources.gojoColors.primaryColor,
              size: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
