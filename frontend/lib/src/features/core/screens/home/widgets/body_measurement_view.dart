import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/services/user_service.dart';
import 'package:frontend/src/utils/fitness_app_them.dart';

class BodyMeasurementView extends StatelessWidget {
  const BodyMeasurementView({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final bmi = UserService.calculateBMI(user.height!, user.weight!);
    final weightCategory = UserService.getCategory(bmi);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: FitnessAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 8,
                bottom: 8,
              ),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: FitnessAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 8,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.height} cm',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: -0.2,
                            color: FitnessAppTheme.darkText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            cHeight,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: FitnessAppTheme.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${bmi.toStringAsFixed(2)}BMI',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.2,
                                color: FitnessAppTheme.darkText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                weightCategory.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '20%',
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.2,
                                color: Color.fromRGBO(37, 56, 64, 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                cBodyFat,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 0, left: 0, right: 00),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/bmicalculatore");
                },
                child: Container(
                  height: 39.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff525252),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      cCalculateBMI,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
