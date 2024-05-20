import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.widget,
      required this.onpressed,
      required this.radius,
      required this.paddinghorizontal,
      required this.paddingvertical});
  final Widget widget;
  final void Function()? onpressed;
  final radius;
  final paddinghorizontal;
  final paddingvertical;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5.0,
      // splashColor: Color.fromRGBO(124, 79, 228, 1),
      padding: EdgeInsets.symmetric(
          horizontal: paddinghorizontal, vertical: paddingvertical),
      color: kPrimaryColor,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      onPressed: onpressed,
      child: widget,
    );
  }
}
