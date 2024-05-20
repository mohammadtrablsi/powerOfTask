import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField(
      {super.key,
      required this.title,
      required this.controller,
      required this.text,
      required this.floatingLabelBehavior,
      required this.maxLines,
      required this.LabelSize,
      required this.isUpdateTaskPage,
      this.fontSize,
      this.minLines,
      this.onChange});
  final String title;
  final controller;
  final String text;
  final floatingLabelBehavior;
  final maxLines;
  final LabelSize;
  final bool isUpdateTaskPage;
  final fontSize;
  final minLines;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isUpdateTaskPage
            ? Container()
            : Row(
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
        SizedBox(
          height: 1.h,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(3.w),
          child: TextFormField(
            onChanged: onChange,
            keyboardType: TextInputType.emailAddress,
            controller: controller,
            style: isUpdateTaskPage
                ? TextStyle(
                    color: Colors.grey,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold)
                : const TextStyle(color: Colors.grey), // Set the text color
            decoration: InputDecoration(
                label: isUpdateTaskPage
                    ? null
                    : Text(
                        text,
                        style: TextStyle(fontSize: LabelSize),
                      ),
                filled: true, // Set filled to true
                // fillColor: isUpdateTaskPage?const Color(0xFFEFEFEF):Colors.grey[200],
                border: InputBorder.none,
                floatingLabelBehavior:
                    floatingLabelBehavior // Set the background color
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.blue), // Set the focused border color
                // ),

                ),
            maxLines: maxLines,
            minLines: minLines,
          ),
        ),
      ],
    );
  }
}
