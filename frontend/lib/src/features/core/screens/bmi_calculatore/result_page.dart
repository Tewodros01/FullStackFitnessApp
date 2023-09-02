import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/constants/styles.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_card.dart';
import 'package:frontend/src/features/core/screens/bmi_calculatore/widgets/bmi_large_button.dart';
import 'package:frontend/src/features/core/services/user_service.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.bmi});
  final double bmi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(cBmiTitle, context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Your results',
                textAlign: TextAlign.center,
                style: cLargeTextStyle,
              ),
              const SizedBox(height: 17),
              Expanded(
                child: BMICard(
                  heights: 50.0,
                  widths: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          UserService.getCategory(bmi).toUpperCase(),
                          style: cLargeTextStyle,
                        ),
                        Text(
                          bmi.toString(),
                          style: cLargeTextStyle,
                        ),
                        Text(
                          UserService.getInterpretation(bmi),
                          style: cLargeTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              BMILargeButton(
                text: 'TRY AGAIN',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
