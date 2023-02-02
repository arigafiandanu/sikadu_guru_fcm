import 'package:flutter/material.dart';

class cardhomepage extends StatelessWidget {
  final Function() ontap;
  final Icon icon;
  final Color warnaTerang;
  final Color warna;
  final String kategori;
  const cardhomepage({
    Key? key,
    required this.ontap,
    required this.warnaTerang,
    required this.warna,
    required this.icon,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: warnaTerang,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.blue.withAlpha(30),
        onTap: ontap,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 5,
              ),
              Text(
                kategori,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
