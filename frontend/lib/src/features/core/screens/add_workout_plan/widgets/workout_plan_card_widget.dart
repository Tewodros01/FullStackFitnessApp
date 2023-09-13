import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/utils/themes/theme.dart';
import 'package:get/get.dart';

class WorkoutPlanCardWidget extends StatelessWidget {
  const WorkoutPlanCardWidget({super.key, required this.workoutPlan});
  final Workout workoutPlan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: _getBGCLr(workoutPlan.workoutColor ?? 0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "yourNextWorkout".tr,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  workoutPlan.workoutName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_tree_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${workoutPlan.workoutStartTime}-${workoutPlan.workoutEndTime}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: ListView.builder(
                    itemCount: workoutPlan.exerciseCategory!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      ExerciseCategory exerciseCategory =
                          workoutPlan.exerciseCategory![index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Color(0xFFFFFFFF),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            exerciseCategory.exerciseCategoryThumbnailImageUrl,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  workoutPlan.workoutNote ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                workoutPlan.workoutIsCompleted == 1
                    ? "completed".tr
                    : "todo".tr,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBGCLr(int no) {
    switch (no) {
      case 0:
        return blueishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return blueishClr;
    }
  }
}
