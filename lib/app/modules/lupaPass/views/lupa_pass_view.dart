import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lupa_pass_controller.dart';

class LupaPassView extends GetView<LupaPassController> {
  const LupaPassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LupaPassView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LupaPassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
