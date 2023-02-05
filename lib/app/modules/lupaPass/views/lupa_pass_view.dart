import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikadu_guru/app/controllers/auth_c_controller.dart';

import '../../../widget/buttonW.dart';
import '../../../widget/textfieldW.dart';
import '../controllers/lupa_pass_controller.dart';

class LupaPassView extends GetView<LupaPassController> {
  final authC = Get.put(AuthCController());

  LupaPassView({Key? key}) : super(key: key);
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
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Lupa Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: Get.width,
            height: Get.height * 0.4,
            child: Lottie.asset(
              "assets/lottie/lupa_password.json",
            ),
          ),
          Column(
            children: [
              CustomFormField(
                headingText: "Email",
                hintText: "Email",
                obsecureText: false,
                suffixIcon: const SizedBox(),
                controller: authC.emailC,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.emailAddress,
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          ButtonW(
            onTap: () {
              authC.lupaPass(authC.emailC.text);
            },
            text: "Lupa Passwod",
          )
        ],
      ),
    );
  }
}
