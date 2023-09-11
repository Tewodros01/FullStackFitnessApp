import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/authentication/controllers/signin_controllers.dart';
import 'package:frontend/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(SignInControllers());
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: cFormHeigth - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controllers.email,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: cEmail,
                hintText: cEmail,
                border: const OutlineInputBorder(),
              ),
              validator: (value) => validateEmail(value),
            ),
            const SizedBox(height: cFormHeigth - 10),
            Obx(
              () => TextFormField(
                controller: controllers.password,
                decoration: InputDecoration(
                  label: Text(cPassword),
                  prefixIcon: const Icon(Icons.key_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controllers.hidePassword.value =
                          !controllers.hidePassword.value;
                    },
                    color: Colors.redAccent.withOpacity(.4),
                    icon: Icon(
                      controllers.hidePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) => validate(value, cPassword),
                obscureText: controllers.hidePassword.value,
              ),
            ),
            const SizedBox(height: cFormHeigth),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: Text(cForgetPassword),
              ),
            ),
            Obx(
              () => controllers.isAsyncCallProcess.value
                  ? const Center(
                      child: DottedCircularProgressIndicatorFb(
                        currentDotColor: cSecondaryColor,
                        defaultDotColor: cPrimaryColor,
                        numDots: 8,
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            controllers.isAsyncCallProcess.value = true;
                            try {
                              await SignInControllers.instance.signInUser(
                                      controllers.email.text.trim(),
                                      controllers.password.text.trim())
                                  ?
                                  // If the Logged-In was successful
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(cAppName),
                                          content:
                                              Text(cLoginSuccessfulySubTitle),
                                          actions: [
                                            TextButton(
                                              child: Text(cOk),
                                              onPressed: () {
                                                // Navigator.of(context).pop();
                                                // Navigator.of(context)
                                                //     .pushNamedAndRemoveUntil(
                                                //   "/login",
                                                //   (route) => false,
                                                // );
                                                Get.to(() =>
                                                    const DashBoardScreen());
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  // If the email is already registered
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(cAppName),
                                          content: Text(
                                            cInvalidEmailOrPassword,
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(cOk),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                            } catch (e) {
                              // If there was an error during the registration process
                              controllers.isAsyncCallProcess.value = false;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(Config.appName),
                                    content: Text(
                                        "$cAnErrorOccurred: ${e.toString()}"),
                                    actions: [
                                      TextButton(
                                        child: Text(cOk),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text(cSignin),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value!.isEmpty) {
      return "$inputName is required";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
