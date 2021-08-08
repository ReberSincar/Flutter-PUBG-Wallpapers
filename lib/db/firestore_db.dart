import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FireStoreDB extends GetxService {
  FirebaseFirestore firebaseInstance;
  String pubgImageCollection = 'wallpapers';

  @override
  onInit() {
    firebaseInstance = FirebaseFirestore.instance;
    super.onInit();
  }

  getPubgImages() {
    return firebaseInstance
        .collection(pubgImageCollection)
        .orderBy('created_at', descending: true)
        .limit(30);
  }

  getNextPubgImages(lastVisible) {
    return firebaseInstance
        .collection(pubgImageCollection)
        .orderBy('created_at', descending: true)
        .startAfterDocument(lastVisible)
        .limit(30);
  }

  addViewCountPubg(String documentID, int viewCount) {
    firebaseInstance
        .collection(pubgImageCollection)
        .doc(documentID)
        .update({'view_count': viewCount + 1});
  }

  addFavCountPubg(String documentID, int favCount) {
    firebaseInstance
        .collection(pubgImageCollection)
        .doc(documentID)
        .update({'fav_count': favCount + 1});
  }
}
