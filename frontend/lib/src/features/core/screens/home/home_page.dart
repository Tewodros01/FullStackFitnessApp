import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/screens/home/gym_detail/gym_detailsa_screen.dart';
import 'package:frontend/src/features/core/screens/home/widgets/exercise_category.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/utils/assets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(staticExerciseProvider.notifier).loadExercisesFromJson();
    final exerciseCategories = ref.watch(staticExerciseProvider);
    if (exerciseCategories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // List of gyms
    final List<Gym> gyms = [
      Gym(
        gymName: 'Gym A',
        gymMonthlyPayment: 50.0,
        gymLocation: 'Location A',
        gymImageAsset: AssetsImages.userJpg,
      ),
      Gym(
        gymName: 'Gym B',
        gymMonthlyPayment: 60.0,
        gymLocation: 'Location B',
        gymImageAsset: AssetsImages.userJpg,
      ),
      // Add more gyms as needed
    ];

    return Scaffold(
      appBar: appBar(cHome, context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            ExerciseCategoryWidget(exerciseCategories: exerciseCategories),
            SizedBox(height: 10.h),

            // Display the list of gyms
            DisplayListOfGym(gyms: gyms),
            SizedBox(height: 52.h),
          ],
        ),
      ),
    );
  }
}

class DisplayListOfGym extends StatelessWidget {
  const DisplayListOfGym({
    super.key,
    required this.gyms,
  });

  final List<Gym> gyms;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: gyms.length,
        itemBuilder: (context, index) {
          final gym = gyms[index];
          return ListTile(
            leading: Image.asset(gym.gymImageAsset),
            title: Text(gym.gymName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Payment: \$${gym.gymMonthlyPayment.toStringAsFixed(2)}',
                ),
                Text('Location: ${gym.gymLocation}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GymDetailsScreen(gym: gym),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
