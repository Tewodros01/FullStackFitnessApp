import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/form/form_header_widget.dart';
import 'package:frontend/src/constants/image_strings.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/widgets/signin_footer_widget.dart';
import 'package:frontend/src/features/authentication/screens/signin_screen/widgets/signin_form_widget.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(cDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeaderWidget(
                  image: cAppLogoImage,
                  title: cLoginTitle,
                  subTitle: cLoginSubTitle,
                ),
                const SizedBox(height: 10),
                const SignInForm(),
                const SignInFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
