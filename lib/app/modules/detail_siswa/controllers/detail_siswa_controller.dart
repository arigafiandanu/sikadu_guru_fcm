import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailSiswaController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> streamSiswa(String email) async {
    
    DocumentReference<Map<String, dynamic>> siswa =
        firestore.collection("Siswa").doc(email);

    return siswa.get();
  }
}
