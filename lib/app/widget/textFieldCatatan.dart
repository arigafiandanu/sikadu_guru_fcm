import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/textStyle.dart';

class TextFieldCatatan extends StatelessWidget {
  final String hint;
  final bool readOnly;
  final TextEditingController? controller;
  const TextFieldCatatan({
    super.key,
    required this.hint,
    required this.controller,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.whiteshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  maxLength: 250,
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
            ],
          ),
        ),
      ],
    );
  }
}
