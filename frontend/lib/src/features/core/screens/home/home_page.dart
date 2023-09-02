import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/features/core/screens/home/widgets/exercise_category.dart';
import 'package:frontend/src/providers/providers.dart';

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
      appBar: appBar('Home', context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              ExerciseCategoryWidget(exerciseCategories: exerciseCategories),
              //  const LocalExerciseCategoryWidget(),
              SizedBox(height: 10.h),
              SizedBox(height: 52.h),
            ],
          ),
        ),
      ),
    );
  }
}
