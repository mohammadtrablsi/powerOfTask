import 'package:flutter/material.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture appToast(BuildContext context,String text) {
  return showToast(text,
   context: context,
   animation: StyledToastAnimation.slideFromTop,
   reverseAnimation: StyledToastAnimation.fade,
   position: StyledToastPosition.top,
   animDuration: const Duration(seconds: 2),
   duration: const Duration(seconds: 4),
   curve: Curves.elasticOut,
   reverseCurve: Curves.linear,
);
}
