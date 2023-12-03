import 'package:flutter/material.dart';
import 'package:star_hub/common/entity/response_entity.dart';
import 'package:star_hub/common/value_state.dart';

extension ValueStateWithResponse<T> on ValueStateNotifier<T> {
  void withResponse(Future<ResponseEntity<T>> response) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loading();
      response.then((value) {
        if (value.entity == null && value.message == null) {
          none();
        } else if (value.isSuccess) {
          success(value: value.entity, message: value.message);
        } else {
          error(value: value.entity, message: value.message);
        }
      });
    });
  }
}