import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key, required this.gym});
  final Gym gym;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(
          gym.gymName,
          style: const TextStyle(
            fontSize: 17.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Image.asset(gym.gymImage!), // Display the gym image
            SizedBox(height: 16.0),
            Text('${"gymName".tr}: ${gym.gymName}'),
            Text('${"monthlyPayment".tr}: \$${gym.gymMonthlyPayment}'),
            Text('${"location".tr}: ${gym.gymLocation}'),
            SizedBox(height: 16.0),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                final gymNotifier = ref.read(gymsProvider.notifier);
                final isJoiningGym = ref.watch(gymsProvider).isLoading;

                return isJoiningGym
                    ? CircularProgressIndicator() // Show circular progress indicator
                    : ElevatedButton(
                        onPressed: () async {
                          final success = await gymNotifier.joinGym(gym.gymId);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${"youHaveJoined".tr} ${gym.gymName}!'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${"failedToJoin".tr} ${gym.gymName}. ${"pleaseTryAgain".tr}.'),
                              ),
                            );
                          }
                        },
                        child: Text('joinGym'.tr),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
