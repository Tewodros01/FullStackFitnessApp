import 'package:flutter/material.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/models/workout_model.dart';
import 'package:frontend/src/features/core/screens/workout_plan/widgets/workout_exercise_expandable_list_item_widget.dart.dart';
import 'package:frontend/src/utils/themes/theme.dart';
import 'package:intl/intl.dart';

class WorkoutPlanDetailScreen extends StatelessWidget {
  const WorkoutPlanDetailScreen({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: _getBGCLr(workout.workoutColor!),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _getBGCLr(workout.workoutColor!),
        foregroundColor: Colors.white,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  workout.workoutName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                trailing: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "60 mins",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shutter_speed,
                          color: Colors.white30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Easy",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: workout.exerciseCategory!.length,
                  itemBuilder: (_, index) {
                    ExerciseCategory exerciseCategory =
                        workout.exerciseCategory![index];
                    return WorkoutExerciseExpandableListItem(
                      exerciseCategory: exerciseCategory,
                    );
                  },
                ),
              )
            ],
          ),
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
