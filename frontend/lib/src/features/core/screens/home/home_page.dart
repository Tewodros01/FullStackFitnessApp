import 'package:flutter/material.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/features/core/screens/home/gym_detail/gym_detailsa_screen.dart';
import 'package:frontend/src/features/core/screens/home/widgets/exercise_category.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(staticExerciseProvider.notifier).loadExercisesFromJson();
    final exerciseCategories = ref.watch(staticExerciseProvider);
    if (exerciseCategories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: appBar("home".tr, context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            ExerciseCategoryWidget(exerciseCategories: exerciseCategories),
            SizedBox(height: 10.h),
            const DisplayListOfGym(),
            SizedBox(height: 52.h),
          ],
        ),
      ),
    );
  }
}

class DisplayListOfGym extends ConsumerWidget {
  const DisplayListOfGym({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gyms = ref.watch(gymsProvider);
    if (gyms.gyms.isEmpty) {
      ref.watch(gymsProvider.notifier).getGyms();
      return const Center(child: CircularProgressIndicator());
    }
    return Expanded(
      child: ListView.builder(
        itemCount: gyms.gyms.length,
        itemBuilder: (context, index) {
          final gym = gyms.gyms[index];
          return ListTile(
            leading: gym.gymImage != null
                ? Image.asset(gym.gymImage!)
                : const SizedBox(), // Use a SizedBox if gymImage is null
            title: Text(gym.gymName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Payment: \$${gym.gymMonthlyPayment}',
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
