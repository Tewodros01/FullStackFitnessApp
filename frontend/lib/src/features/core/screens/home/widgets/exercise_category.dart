import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/screens/home/widgets/video_play_widgets.dart';

class ExerciseCategoryWidget extends ConsumerWidget {
  const ExerciseCategoryWidget({
    super.key,
    required this.exerciseCategories,
  });

  final List<ExerciseCategory> exerciseCategories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cCategories,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
        SizedBox(
          height: 170.h,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 24.w),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: exerciseCategories.length,
            itemBuilder: (context, index) {
              final exercise = exerciseCategories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoDisplayWidget(exercise: exercise.exercise!),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        width: 150.w,
                        height: 170.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(
                              exercise.exerciseCategoryThumbnailImageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 39.h,
                                color: const Color(0xff525252),
                                child: Center(
                                  child: Text(
                                    exercise.exerciseCategoryName,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 17.w,
              );
            },
          ),
        ),
      ],
    );
  }
}
