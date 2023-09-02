import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/notifiers/book_notifiers.dart';
import 'package:frontend/src/features/core/notifiers/exercise_notifiers.dart';
import 'package:frontend/src/features/core/notifiers/static_exercise_notifier.dart';
import 'package:frontend/src/features/core/notifiers/user_notifier.dart';
import 'package:frontend/src/features/core/services/book_service.dart';
import 'package:frontend/src/features/core/services/exercise_category_service.dart';
import 'package:frontend/src/features/core/states/book_state.dart';
import 'package:frontend/src/features/core/states/exercise_state.dart';
import '../features/core/notifiers/video_controller_notifier.dart';
import '../features/core/states/video_state.dart';

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, UserModel>(
  (ref) => UserNotifier(
    ref.watch(apiService),
  ),
);
final staticExerciseProvider = StateNotifierProvider<
    StaticExerciseCategoryNotifier, List<ExerciseCategory>>(
  (ref) => StaticExerciseCategoryNotifier(ref.watch(exerciseCategoryService)),
);

final exerciseProvider =
    StateNotifierProvider<ExerciseCategoryNotifier, ExerciseCategoryState>(
  (ref) => ExerciseCategoryNotifier(ref.watch(exerciseCategoryService)),
);

final booksProvider = StateNotifierProvider<BookNotifier, BooksState>(
  (ref) => BookNotifier(ref.watch(bookService)),
);

final videoControllerProvider =
    StateNotifierProvider<VideoControllerNotifier, VideoState>(
  (ref) => VideoControllerNotifier(),
);
