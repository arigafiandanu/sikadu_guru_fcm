import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/textStyle.dart';

class TextFormButtonW extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const TextFormButtonW({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 5,
            top: 10,
          ),
          child: Text(
            title,
            style: KTextStyle.textFieldHeading,
          ),
        ),
        Container(
          height: Get.height * 0.05,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          decoration: BoxDecoration(
            color: AppColors.grayshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  readOnly: widget == null ? false : true,
                  controller: controller,
                  style: KTextStyle.textFieldHintStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
