import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.text,
      required this.color,
      required this.categoryId,
      required this.Id,
      required this.onTap});
  final String text;
  final color;
  final int categoryId;
  final int Id;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: categoryId == Id ? color : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: 2.5,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
