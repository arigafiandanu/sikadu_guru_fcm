import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PengumumanKelasController extends GetxController {
 FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamPengumuman() async* {
    var kelas = await firestore
        .collection("Guru")
        .doc(auth.currentUser!.email)
        .get()
        .then((value) => value.data()?['mengajarKelas']);

    Query<Map<String, dynamic>> pengumuman = firestore
        .collection("pengumuman")
        .where("kategoriPenerima", isEqualTo: kelas);
    yield* pengumuman.snapshots();
  }

  void deteteDocument(String id) async {
    try {
      await firestore.collection("pengumuman").doc(id).delete();
      Get.back();
      Get.snackbar("Berhasil", "Penguman berhasil dihapus");
    } catch (e) {
      Get.back();
      Get.snackbar(
          "Gagal menghapus pengumuman", "Silahkan coba beberapa saat lagi");
    }
  }
}
