import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDB {
  static FireStoreDB _fireStoreDB;
  FirebaseFirestore firebaseInstance;
  String pubgImageCollection = 'wallpapers';
  FireStoreDB._() {
    firebaseInstance = FirebaseFirestore.instance;
  }

  static getInstance() {
    if (_fireStoreDB == null) _fireStoreDB = FireStoreDB._();
    return _fireStoreDB;
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
