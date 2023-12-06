import 'package:flutter/material.dart';
import 'package:star_hub/common/value_state.dart';


abstract class ValueStateNotifierWidget<T> extends Widget {
  final ValueStateNotifier<T> state;

  const ValueStateNotifierWidget(this.state, {super.key});
}
