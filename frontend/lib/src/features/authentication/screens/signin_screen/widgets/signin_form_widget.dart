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
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: cEmail,
                hintText: cEmail,
                border: OutlineInputBorder(),
              ),
              validator: (value) => validateEmail(value),
            ),
            const SizedBox(height: cFormHeigth - 10),
            Obx(
              () => TextFormField(
                controller: controllers.password,
                decoration: InputDecoration(
                  label: const Text(cPassword),
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
                child: const Text(cForgetPassword),
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
                                          title: const Text(Config.appName),
                                          content: const Text(
                                              "User Logged-In Successfuly"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Ok"),
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
                                          title: const Text(Config.appName),
                                          content: const Text(
                                            "Invalid Email or Password",
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text("Ok"),
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
                                        "An error occurred: ${e.toString()}"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Ok"),
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
                        child: const Text(cSignin),
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
