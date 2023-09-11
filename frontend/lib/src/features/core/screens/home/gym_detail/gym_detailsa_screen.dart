import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key, required this.gym});
  final Gym gym;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(gym.gymImageAsset), // Display the gym image
            SizedBox(height: 16.0),
            Text('Gym Name: ${gym.gymName}'),
            Text(
                'Monthly Payment: \$${gym.gymMonthlyPayment.toStringAsFixed(2)}'),
            Text('Location: ${gym.gymLocation}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to join the gym here
                // You can navigate to a success page or perform the desired action
                // For this example, we'll just show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You have joined ${gym.gymName}!'),
                  ),
                );
              },
              child: Text('Join Gym'),
            ),
          ],
        ),
      ),
    );
  }
}
