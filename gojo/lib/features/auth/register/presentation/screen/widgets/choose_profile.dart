import 'package:flutter/material.dart';

import '../../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class ChooseProfilePic extends StatelessWidget {
  const ChooseProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: Image.asset(Resources.gojoImages.headShot).image,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.add_circle,
            color: Resources.gojoColors.primaryColor,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
