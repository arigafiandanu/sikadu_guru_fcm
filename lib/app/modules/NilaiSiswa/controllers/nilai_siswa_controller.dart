import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NilaiSiswaController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> streamSiswa() async {
    var waliKelas = await firestore
        .collection("Guru")
        .doc(auth.currentUser!.email)
        .get()
        .then((value) => value.data()?['mengajarKelas']);

    Query<Map<String, dynamic>> siswa = firestore
        .collection("Siswa")
        .where("role", isEqualTo: "orangTua")
        .where("kelas", isEqualTo: waliKelas);

    return siswa.get();
  }
}
