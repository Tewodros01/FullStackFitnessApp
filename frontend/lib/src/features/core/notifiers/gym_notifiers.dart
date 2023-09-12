import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/gym_service.dart';
import 'package:frontend/src/features/core/states/gym_state.dart';

class GymNotifier extends StateNotifier<GymsState> {
  GymNotifier(this._gymService) : super(GymsState());
  final GymService _gymService;

  Future<void> getGyms() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    // state = state.copyWith(isLoading: true);
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );
    final gyms = await _gymService.getGyms();
    final newGyms = [...state.gyms, ...gyms!];
    if (gyms.length % 10 != 0 || gyms.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(gyms: newGyms);
      //  _page++;
      state = state.copyWith(isLoading: false);
    });
  }

  Future<bool> joinGym(int gymId) async {
    // Check if the user is already a member or any other conditions
    // You can implement your business logic here

    // Assuming you have a method in your _gymService for joining a gym, call it here
    final result = await _gymService.joinGym(gymId); // Assuming gym has an ID

    return result; // Return true for success, false for failure
  }
}
