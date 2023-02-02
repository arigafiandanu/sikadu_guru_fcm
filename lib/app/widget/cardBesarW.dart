import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardBesarW extends StatelessWidget {
  final Function() ontap;
  final String title;
  final String jumlahSiswa;
  final Icon icon;
  final Color colorCard;
  final Color splashColor;

  const CardBesarW({
    super.key,
    required this.ontap,
    required this.title,
    required this.jumlahSiswa,
    required this.icon,
    required this.colorCard,
    required this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Card(
        elevation: 5,
        color: colorCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: splashColor,
          onTap: ontap,
          child: Container(
            width: Get.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    width: Get.width / 2.5,
                    height: Get.height,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          jumlahSiswa,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: Get.width / 2.5,
                    height: Get.height,
                    child: icon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
