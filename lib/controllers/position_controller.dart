import 'package:get/get.dart';

class PositionController extends GetxController {
  var position = 0.obs;
  changePosition(int newPosition) {
    position.value = newPosition;
  }
}
