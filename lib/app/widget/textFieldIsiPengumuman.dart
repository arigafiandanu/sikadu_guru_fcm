import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/textStyle.dart';

class CustomFormFieldIsiPengumuman extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  final bool readOnly;
  final String hint;

  const CustomFormFieldIsiPengumuman({
    Key? key,
    required this.headingText,
    required this.hintText,
    required this.obsecureText,
    required this.suffixIcon,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.maxLines,
    required this.readOnly,
    required this.hint,
  }) : super(key: key);

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
            headingText,
            style: KTextStyle.textFieldHeading,
          ),
        ),
        Container(
          height: 150,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.grayshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              autofocus: true,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              maxLength: 1000,
              readOnly: readOnly,
              controller: controller,
              style: KTextStyle.textFieldHintStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                focusColor: Colors.grey.shade100,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: context.theme.backgroundColor,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
