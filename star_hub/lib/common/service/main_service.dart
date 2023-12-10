import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/state/state.dart';
import 'package:star_hub/home/model/home_entity.dart';
import 'package:star_hub/home/model/home_repository.dart';
import 'package:star_hub/home/model/state.dart';
import 'package:dio/dio.dart';

final mainServiceProvider =
    StateNotifierProvider<MainService, MainState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return MainService(repository);
});

class MainService extends StateNotifier<MainState> {
  final HomeRepository repository;

  MainService(this.repository) : super(MainStateNone()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      state = MainStateLoading();
      List<LunarData>? lunarData = await getLunarData(
          DateTime.now().year.toString(),
          DateTime.now().month.toString().padLeft(2, '0'));

      if (lunarData != null) {
        state = MainStateSuccess(lunarData);
      } else {
        state = MainStateError('에러: 데이터를 불러올 수 없습니다.');
      }
    } catch (e) {
      state = MainStateError('에러: $e');
    }
  }

  Future<List<LunarData>?> getLunarData(String year, String month) async {
    try {
      final response = await repository.getLunarData(year, month);
      return response;
    } on DioException catch (e) {
      print('Failed to load lunar data DioError: ${e.message}');
    } catch (e) {
      print('Unexpected Error: $e');
    }
    return null;
  }
}
