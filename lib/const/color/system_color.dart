import 'package:flutter/material.dart';

enum SystemColorKey { warning, success, error }

extension SystemColorKeyValue on SystemColorKey {
  String get value {
    switch (this) {
      case SystemColorKey.warning:
        return 'warning';
      case SystemColorKey.success:
        return 'success';
      case SystemColorKey.error:
        return 'error';
    }
  }
}

const Map<SystemColorKey, Color> systemColor = {
  SystemColorKey.warning: Color(0xFFF9A825),
  SystemColorKey.success: Color(0xFF4CAF50),
  SystemColorKey.error: Color(0xFFD32F2F),
};
