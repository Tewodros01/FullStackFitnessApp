import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/providers/providers.dart';

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
          cFoodList,
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
            Text('Gym Name: ${gym.gymName}'),
            Text('Monthly Payment: \$${gym.gymMonthlyPayment}'),
            Text('Location: ${gym.gymLocation}'),
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
                                content:
                                    Text('You have joined ${gym.gymName}!'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Failed to join ${gym.gymName}. Please try again.'),
                              ),
                            );
                          }
                        },
                        child: Text('Join Gym'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
