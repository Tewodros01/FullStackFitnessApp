import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/screens/profile/update_profile_screen/widgets/profile_picture_widget.dart';
import 'package:frontend/src/features/core/screens/profile/update_profile_screen/widgets/update_profile_widget.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(
          "Update Profile",
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const ProfilePicture(),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  user.fullName,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(cDefaultSize),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UpdateProfileWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
