import 'package:flutter/material.dart';
import 'package:pubg_wallpaper/constants/colors.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation<Color>(lightColor),
      ),
    );
  }
}
