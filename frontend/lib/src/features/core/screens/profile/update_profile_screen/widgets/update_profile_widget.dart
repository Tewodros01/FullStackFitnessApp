import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/controllers/update_profile_controller.dart';
import 'package:frontend/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateProfileWidget extends ConsumerStatefulWidget {
  const UpdateProfileWidget({super.key});

  @override
  ConsumerState<UpdateProfileWidget> createState() =>
      _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends ConsumerState<UpdateProfileWidget> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(UpdateProfileController());
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controllers.fullname,
            decoration: const InputDecoration(
                label: Text(cFullName),
                prefixIcon: Icon(Icons.person_outline_rounded)),
            validator: (value) => validate(value, cFullName),
          ),
          const SizedBox(height: cFormHeigth - 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              label: Text(cGender),
              prefixIcon: Icon(Icons.people_alt_rounded),
            ),
            items: <String>['Male', 'Female']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              controllers.gender = value!;
            },
            validator: (value) => validate(value, cGender),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            readOnly: true,
            autofocus: false,
            controller: controllers.birthdayController,
            decoration: InputDecoration(
              label: const Text("Birth Day"),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: () async {
                  DateTime? selectedDate = await _getDateFromUser();
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                    controllers.birthdayController.text =
                        DateFormat.yMd().format(_selectedDate);
                  }
                },
              ),
            ),
            validator: (value) => validate(value, "Birth Day"),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.height,
            decoration: const InputDecoration(
              label: Text(cHeight),
              prefixIcon: Icon(Icons.height_rounded),
            ),
            validator: (value) => validate(value, cHeight),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.weight,
            decoration: const InputDecoration(
              label: Text(cWeight),
              prefixIcon: Icon(Icons.straighten_rounded),
            ),
            validator: (value) => validate(value, cWeight),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.email,
            decoration: const InputDecoration(
              label: Text(cEmail),
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) => validateEmail(value),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.phoneNo,
            decoration: const InputDecoration(
              label: Text(cPhoneNumber),
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) => validate(value, cPhoneNumber),
          ),
          const SizedBox(height: cFormHeigth - 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              label: Text(cAim),
              prefixIcon: Icon(Icons.fitness_center_rounded),
            ),
            items: <String>['Loose', 'Maintain', 'Gain']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              controllers.aim = value!;
            },
            validator: (value) => validate(value, "Aim"),
          ),
          const SizedBox(height: cFormHeigth - 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              label: Text(cActivityExtent),
              prefixIcon: Icon(Icons.directions_run_rounded),
            ),
            items: <String>[
              'Little to no exercise',
              'Moderately active',
              'Very active'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              controllers.activityExtent = value!;
            },
            validator: (value) => validate(value, "Activity Extent"),
          ),
          const SizedBox(height: cFormHeigth - 20),
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
                            fullName: controllers.fullname.text.trim(),
                            gender: controllers.gender,
                            birthday:
                                controllers.birthdayController.text.trim(),
                            height: int.parse(controllers.height.text.trim()),
                            weight: int.parse(controllers.weight.text.trim()),
                            email: controllers.email.text.trim(),
                            phoneNo: controllers.phoneNo.text.trim(),
                            aim: controllers.aim,
                            activityExtent: controllers.activityExtent,
                          );
                          try {
                            print("height : ${user.height}");
                            print("weight : ${user.weight}");
                            print("aim : ${user.aim}");
                            print("activityExtent : ${user.activityExtent}");
                            print("birthday : ${user.birthday}");
                            print("phoneNo : ${user.phoneNo}");
                            print(
                                "Profile Image ${controllers.imageFile.value}");
                            await ref
                                    .read(userProvider.notifier)
                                    .updateUserInfo(
                                        user, controllers.imageFile.value)
                                ?
                                // If the registration was successful
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(Config.appName),
                                        content: const Text(
                                            "Updat completed successfully"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Ok"),
                                            onPressed: () {
                                              Get.to(
                                                () => DashBoardScreen(),
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
                                        content:
                                            const Text("Internal server error"),
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
                            controllers.isAsyncCallProcess.value = false;
                          } catch (e) {
                            // If there was an error during the registration process
                            controllers.isAsyncCallProcess.value = false;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(Config.appName),
                                  content: Text(
                                    "An error occurred: ${e.toString()}",
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
                          }
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

  String? validate(String? value, String cFullName) {
    if (value?.isEmpty ?? true) {
      return "$cFullName is required";
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

  Future<DateTime?> _getDateFromUser() async {
    return await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
}
