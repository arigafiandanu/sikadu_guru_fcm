import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../model/userModel.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late DocumentReference<UserData> userinfo;
  late String currentUser;
  var userModel = UserData().obs;
  UserData? userdata;
  @override
  void onInit() {
    super.onInit();

    getInfoUser();
    getCurrentUser();
  }

  void getInfoUser() {
    var infoUser = firestore
        .collection("users")
        .doc('auth.currentUser!.email')
        .withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userdata, _) => userdata.toJson(),
        );
    userinfo = infoUser;
  }

  void getCurrentUser() async {
    final data =
        await firestore.collection("users").doc(auth.currentUser!.email).get();
    final getdata = data.data() as Map<String, dynamic>;
    userModel(UserData.fromJson(getdata));
    userModel.refresh();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String? email = auth.currentUser!.email;

    yield* firestore.collection("users").doc(email).snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamjmlAdmin() {
    Query<Map<String, dynamic>> admin =
        firestore.collection("users").where('role', isEqualTo: 'admin');
    return admin.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamjmlGuru() {
    Query<Map<String, dynamic>> admin =
        firestore.collection("users").where('role', isEqualTo: 'Guru');
    return admin.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamjmlSiswa() {
    Query<Map<String, dynamic>> admin =
        firestore.collection("users").where('role', isEqualTo: 'orangTua');
    return admin.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamJmlPengumuman() {
    Query<Map<String, dynamic>> pengumuman = firestore.collection("pengumuman");
    return pengumuman.snapshots();
  }
}
