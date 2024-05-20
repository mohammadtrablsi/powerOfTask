import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TaskLastPart extends StatelessWidget {
  const TaskLastPart(
      {super.key,
      required this.title,
      required this.dateOnTap,
      required this.dateText,
      required this.buttonColor,
      required this.buttonText,
      required this.buttonTextColor,
      this.icon,
      required this.horizontalButton,
      required this.onPressedButton,
      required this.isUpdateTaskPage,
      required this.canCreate});
  final String title;
  final dateOnTap;
  final String dateText;
  final Color buttonColor;
  final String buttonText;
  final Color buttonTextColor;
  final icon;
  final horizontalButton;
  final onPressedButton;
  final bool isUpdateTaskPage;
  final canCreate;

  @override
  Widget build(BuildContext context) {
    return isUpdateTaskPage
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                  onTap: dateOnTap,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.w, vertical: 0.7.h),
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Text(dateText),
                  )),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              InkWell(
                  onTap: dateOnTap,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.w, vertical: 0.7.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          dateText,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 2.h,
              ),
              canCreate
                  ? MaterialButton(
                      // splashColor: Color.fromRGBO(124, 79, 228, 1),
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalButton, vertical: 0.5.h),
                      color: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.sp)),
                      onPressed: onPressedButton,
                      child: Text(
                        buttonText,
                        style:
                            TextStyle(fontSize: 12.sp, color: buttonTextColor),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(5.sp)),
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalButton, vertical: 1.h),
                      child: Text(
                        buttonText,
                        style:
                            TextStyle(fontSize: 12.sp, color: buttonTextColor),
                      ),
                    ),
            ],
          );
  }
}
