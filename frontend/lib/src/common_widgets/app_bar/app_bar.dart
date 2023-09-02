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
      GestureDetector(
        onTap: () async {
          await SharedService.logout(context);
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              AssetsSvgs.settingSvg,
              height: 20,
              width: 20,
              color: Colors.black,
            ),
            const Positioned(
              bottom: 32,
              right: -3,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 15),
    ],
  );
}
