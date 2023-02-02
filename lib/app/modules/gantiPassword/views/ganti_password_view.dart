import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ganti_password_controller.dart';

class GantiPasswordView extends GetView<GantiPasswordController> {
  const GantiPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Ganti Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Obx(
            () => TextField(
              controller: controller.passC,
              obscureText: controller.hidePassword.value,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Password Saat ini",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: IconButton(
                  icon: controller.hidePassword.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => TextField(
              controller: controller.newPassC,
              obscureText: controller.hidePassword.value,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Masukkan Password Baru",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: IconButton(
                  icon: controller.hidePassword.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => TextField(
              controller: controller.conNewPassC,
              obscureText: controller.hidePassword.value,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Konfirmasi Password Baru",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: IconButton(
                  icon: controller.hidePassword.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.updatePass();
                  }
                },
                child: Text((controller.isLoading.isFalse)
                    ? "Update Password"
                    : "Loading")),
          )
        ],
      ),
    );
  }
}
