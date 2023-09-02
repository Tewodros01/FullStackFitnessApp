import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/constants/sizes.dart';
import 'package:frontend/src/constants/styles.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/controllers/welcome_controller.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_card.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_content_control.dart';
import 'package:frontend/src/features/core/screens/dashboard/dashboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final controllers = Get.put(WelcomeController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "More Info",
          style: TextStyle(
            fontSize: 17,
            color: cSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: null, // Set the leading icon to null to remove it
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: cDefaultSize,
            left: cDefaultSize,
            right: cDefaultSize,
            bottom: cDefaultSize,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 100),
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
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Aim',
                    labelStyle: cLargeTextStyle,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your aim';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controllers.aim = value;
                  },
                  value: controllers.aim,
                  items: ['Loose', 'Maintain', 'Gain'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Exercise',
                    labelStyle: cLargeTextStyle,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your exercise level';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controllers.exercise = value;
                  },
                  value: controllers.exercise,
                  items: [
                    'Little to no exercise',
                    'Moderately active',
                    'Very active',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => BMICard(
                    heights: 60.0,
                    widths: MediaQuery.of(context).size.width,
                    child: BMIContentControl(
                      label: 'Weight',
                      value: controllers.weight.value,
                      unit: 'kg',
                      onDecrease: () => controllers.weight.value--,
                      onIncrease: () => controllers.weight.value++,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => BMICard(
                    heights: 60,
                    widths: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              const Text(
                                'Height',
                                style: cLargeTextStyle,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                controllers.height.toString(),
                                style: cValueStyle,
                              ),
                              const Text(
                                'cm',
                                style: cLargeTextStyle,
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 20,
                              ),
                            ),
                            child: Slider(
                              min: cMinHeight,
                              max: cMaxHeight,
                              value: controllers.height.toDouble(),
                              activeColor: cSecondaryColor.withOpacity(0.7),
                              inactiveColor: Colors.grey.shade400,
                              onChanged: (newHeight) {
                                controllers.height.value = newHeight.round();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // Show circular progress indicator while creating user
                        controllers.isAsyncCallProcess.value = true;
                        widget.user.height = controllers.height.value;
                        widget.user.weight = controllers.weight.value;
                        widget.user.aim = controllers.aim;
                        widget.user.activityExtent = controllers.exercise;
                        widget.user.birthday =
                            controllers.birthdayController.text.trim();
                        print("Age : ${widget.user.age}");
                        print("height : ${widget.user.height}");
                        print("weight : ${widget.user.weight}");
                        print("aim : ${widget.user.aim}");
                        print("activityExtent : ${widget.user.activityExtent}");
                        print("birthday : ${widget.user.birthday}");
                        try {
                          bool success = await controllers
                              .registerMoreUserInfo(widget.user);
                          controllers.isAsyncCallProcess.value = false;
                          if (success) {
                            // If the registration was successful
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(Config.appName),
                                  content: const Text(
                                      "Registration completed successfully"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Ok"),
                                      onPressed: () {
                                        Get.offAll(() => DashBoardScreen());
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // If the registration was not successful
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(Config.appName),
                                  content: const Text("Internal Server Error"),
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
                        } catch (e) {
                          // If there was an error during the registration process
                          controllers.isAsyncCallProcess.value = false;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(Config.appName),
                                content:
                                    Text("An error occurred: ${e.toString()}"),
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
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value == null || value.isEmpty) {
      return "$inputName is required";
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