import 'package:flutter/material.dart';

class Headerauth extends StatelessWidget implements PreferredSizeWidget {
  double height, paddingBottom;

  Headerauth({super.key, this.height = 150.0, this.paddingBottom = 60.0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.only(bottom: paddingBottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.local_shipping,
              color: Theme.of(context).primaryColor,
              size: 90,
            ),
            Text(
              "TransiGo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
