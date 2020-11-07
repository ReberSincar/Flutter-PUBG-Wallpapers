import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pubg_wallpaper/constants/colors.dart';

import '../widgets/custom_circular_progress.dart';

class LoadingAlertDialog extends StatelessWidget {
  const LoadingAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightColor.withOpacity(0.7),
      content: Container(
        width: Get.width * 0.5,
        height: Get.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircularProgressBar(),
            SizedBox(width: Get.width * 0.1),
            Text(
              'Please Wait...',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
