import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/service/main_service.dart';
import 'package:star_hub/common/state/state.dart';
import 'package:star_hub/home/model/home_entity.dart';

final mainViewModelProvider =
ChangeNotifierProvider((ref) => MainViewModel(ref));

class MainViewModel extends ChangeNotifier {
  Ref ref;
  late MainState state;
  List<LunarData> get data =>
      (state as MainStateSuccess).data;

  MainViewModel(this.ref) {
    state = ref.read(mainServiceProvider);

    ref.listen(mainServiceProvider, (previous, next) {
      print('home State: $previous -> $next');
      if (previous != next) {
        state = next;
        notifyListeners();
      }
    });
  }
}
