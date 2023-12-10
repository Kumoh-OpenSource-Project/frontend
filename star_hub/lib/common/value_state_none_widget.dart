import 'package:flutter/material.dart';
import 'package:star_hub/common/value_state.dart';
import 'package:star_hub/common/value_state_notifier_widget.dart';

class ValueStateNoneWidget<T> extends StatelessWidget
    implements ValueStateNotifierWidget {
  @override
  final ValueStateNotifier<T> state;

  ValueStateNoneWidget(this.state, {Key? key})
      : assert(state.isNone),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black);
  }
}
