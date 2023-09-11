import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/authentication/controllers/signup_controllers.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(SignUpControllers());
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controllers.fullname,
            decoration: InputDecoration(
              label: Text(cFullName),
              prefixIcon: const Icon(Icons.person_outline_rounded),
            ),
            validator: (value) => validate(value, cFullName),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.email,
            decoration: InputDecoration(
              label: Text(cEmail),
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            validator: (value) => validate(value, cEmail),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.phoneNo,
            decoration: InputDecoration(
              label: Text(cPhoneNumber),
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            validator: (value) => validate(value, cPhoneNumber),
          ),
          const SizedBox(height: cFormHeigth - 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              fillColor: Colors.black,
              labelText: cGender,
              prefixIcon: const Icon(Icons.person_2_outlined),
            ),
            validator: (value) => validate(value, cGender),
            onChanged: (value) {
              if (value != null) {
                controllers.gender = value;
              }
            },
            onSaved: (value) {
              if (value != null) {
                controllers.gender = value;
              }
            },
            items: ['Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
          const SizedBox(height: 20),
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
                          // Show circular progress indicator while creating user
                          controllers.isAsyncCallProcess.value = true;
                          final UserModel user = UserModel(
                            email: controllers.email.text.trim(),
                            password: controllers.password.text.trim(),
                            fullName: controllers.fullname.text.trim(),
                            phoneNo: controllers.phoneNo.text.trim(),
                            gender: controllers.gender,
                          );
                          try {
                            await SignUpControllers.instance.createUser(user)
                                ?
                                // If the registration was successful
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(Config.appName),
                                        content: Text(
                                            cRegistrationCompletedSuccessfully),
                                        actions: [
                                          TextButton(
                                            child: Text(cOk),
                                            onPressed: () {
                                              Get.to(
                                                () => WelcomeScreen(user: user),
                                              );
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
                                            "This email is already registered"),
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
                                    "$cAnErrorOccurred: ${e.toString()}",
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
                          }
                          //   Get.to(() => const OTPScrenn());
                        }
                      },
                      child: Text(cSignup.toUpperCase()),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value == null || value.isEmpty) {
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
