import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_crud_5a25/models/pet_model.dart';
// import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  Stream<List<PetModel>> getPets(String collection) {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PetModel.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  Future<void> updatePet(
      String collection, String docId, Map<String, dynamic> data) {
    return _firestore.collection(collection).doc(docId).update(data);
  }

  Future<void> deletePet(String collection, String docId) {
    return _firestore.collection(collection).doc(docId).delete();
  }
}
