import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class AppBarPart extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPart({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.4,
      centerTitle: true,
      title: Text(
        "Hi",
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
      ),
      actions: [
        SizedBox(
          width: 15.w,
          child: PopupMenuButton<String>(
            onSelected: (value) async {},
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Center(child: Text('logout')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
