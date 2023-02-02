import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikadu_guru/app/modules/home/views/home_view.dart';
import 'package:sikadu_guru/app/modules/listChat/views/list_chat_view.dart';
import 'package:sikadu_guru/app/modules/profil/views/profil_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabindex,
              children: [
                HomeView(),
                ListChatView(),
                ProfilView(),
              ],
            ),
          ),
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.textIn,
            elevation: 5,
            activeColor: Colors.white,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.message, title: 'Pesan'),
              TabItem(icon: Icons.person, title: 'Profil'),
            ],
            initialActiveIndex: controller.tabindex,
            onTap: controller.pindahTabIndex,
          ),
        );
      },
    );
  }
}
