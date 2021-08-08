import 'dart:io';
import 'dart:typed_data';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pubg_wallpaper/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_crop/image_crop.dart';

class FileIOService extends GetxService {
  Directory directory;

  @override
  onInit() {
    directory = Directory("/storage/emulated/0/Download");
    controlDirectory();
    super.onInit();
  }

  controlDirectory() async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    } else {
      print('Directory exist');
    }
  }

  saveImageUrl(String url) async {
    final permissionsGranted = await ImageCrop.requestPermissions();
    if (permissionsGranted) {
      String filename = Uri.parse(url).pathSegments.last;
      File file = new File('${directory.path}/$filename');

      if (file.existsSync()) {
        print('file already exist');
        Utils.showShortToast('The picture has already been downloaded');
      } else {
        print('file not found downloading from server');
        var request = await http.get(Uri.parse(url));
        var bytes = request.bodyBytes;
        await file.writeAsBytes(bytes);
        print(file.path);
        Utils.showShortToast('The picture downloaded');
      }
      return file;
    } else {
      print('permission denied');
      Utils.showShortToast('Storage permission needed');
    }
  }

  saveImageFile(File file) async {
    if (file.existsSync()) {
      print('file already exist');
      var image = await file.readAsBytes();
      return image;
    } else {
      Uint8List byteData = await file.readAsBytes();
      var bytes = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      await file.writeAsBytes(bytes);
      print(file.path);
      return bytes;
    }
  }
}
