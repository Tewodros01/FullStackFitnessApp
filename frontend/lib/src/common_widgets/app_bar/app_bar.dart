import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/src/utils/assets.dart';
import 'package:frontend/src/utils/shared_service.dart';

AppBar appBar(String title, BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(AssetsSvgs.drawerMenuSvg),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 17.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      PopupMenuButton<int>(
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<int>(
              value: 1,
              child: Text('Setting'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('Logout'),
            ),
          ];
        },
        onSelected: (int value) async {
          // Handle the selected option here
          if (value == 1) {
            Navigator.of(context).pushNamed('/language_selection');
          } else if (value == 2) {
            await SharedService.logout(context);
          }
        },
        child: SvgPicture.asset(
          AssetsSvgs.settingSvg,
          height: 20,
          width: 20,
          color: Colors.black,
        ),
      ),
      const SizedBox(width: 15),
    ],
  );
}
