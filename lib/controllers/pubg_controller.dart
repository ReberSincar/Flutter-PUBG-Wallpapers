import 'package:pubg_wallpaper/db/firestore_db.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PubgImagesController extends GetxController {
  FireStoreDB fireStoreDB = FireStoreDB.getInstance();
  var listDocument = <ImageModel>[].obs;
  QuerySnapshot collectionState;
  @override
  void onInit() {
    getDocuments();
    super.onInit();
  }

  Future<void> getDocuments() async {
    var collection = fireStoreDB.getPubgImages();
    fetchDocuments(collection);
  }

  Future<void> getDocumentsNext() async {
    // Get the last visible document
    var lastVisible = collectionState.docs[collectionState.docs.length - 1];
    print('listDocument legnth: ${collectionState.size} last: $lastVisible');
    var collection = fireStoreDB.getNextPubgImages(lastVisible);
    fetchDocuments(collection);
  }

  fetchDocuments(Query collection) {
    collection.get().then((value) {
      collectionState =
          value; // store collection state to set where to start next
      value.docs.forEach((element) {
        print('getDocuments ${element.data()}');
        listDocument.add(ImageModel.fromMap(element.data()));
        update();
      });
      print(listDocument.length.toString());
    });
  }

  addFavCount(int position) {
    ImageModel model = listDocument[position];
    model.favCount += 1;
    listDocument[position] = model;
    update();
  }

  addViewCount(int position) {
    ImageModel model = listDocument[position];
    model.viewCount += 1;
    listDocument[position] = model;
    update();
  }

  addViewCountWithID(String id) {
    int position = listDocument.indexWhere((e) => e.id == id);
    ImageModel model = listDocument[position];
    model.viewCount += 1;
    listDocument[position] = model;
    update();
  }

  addFavCountWithID(String id) {
    int position = listDocument.indexWhere((e) => e.id == id);
    ImageModel model = listDocument[position];
    model.favCount += 1;
    listDocument[position] = model;
    update();
  }
}
