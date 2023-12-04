
import 'package:flutter/material.dart';
import 'package:star_hub/common/snackBarUtil.dart';

class ValueStateNotifier<T> extends ChangeNotifier {
  T? value;
  String? _message;
  _State _state = _State.none;

  ValueStateNotifier();

  get isNone => _state == _State.none;

  get isLoading => _state == _State.loading;

  get isSuccess => _state == _State.success;

  get isError => _state == _State.error;

  get message => _message;

  void none({T? value, String? message}) {
    _state = _State.none;
    _message = message;
    this.value = value;
    notifyListeners();
  }

  void loading({T? value, String? message}) {
    _state = _State.loading;
    _message = message;
    this.value = value;
    notifyListeners();
  }

  void success({T? value, String? message}) {
    _state = _State.success;
    _message = message;
    this.value = value;
    notifyListeners();
  }

  void error({T? value, String? message}) {
    _state = _State.error;
    print('isNone$isNone $isSuccess $isError $isLoading');
    _message = message;
    this.value = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    //if (isError) SnackBarUtil.showError(message);
    //if (isSuccess && message != null) SnackBarUtil.showSuccess(message);
    super.notifyListeners();
  }
}

enum _State<T> {
  none,
  loading,
  success,
  error;
}
