import 'package:flutter/material.dart';
import 'package:star_hub/common/value_state.dart';
import 'package:star_hub/common/value_state_notifier_widget.dart';

class ValueStateLoadingWidget<T> extends StatelessWidget
    implements ValueStateNotifierWidget {
  @override
  final ValueStateNotifier<T> state;

  ValueStateLoadingWidget(this.state, {Key? key})
      : assert(state.isLoading),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
