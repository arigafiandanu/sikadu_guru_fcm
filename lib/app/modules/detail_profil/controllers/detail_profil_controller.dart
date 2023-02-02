import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailProfilController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> futureDetailProfil() async {
    DocumentReference<Map<String, dynamic>> guru =
        firestore.collection("Guru").doc(auth.currentUser!.email);

    return guru.get();
  }
}
