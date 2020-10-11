import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigation {
  static Route<Object> route(Widget home) {
    return Platform.isAndroid ? MaterialPageRoute(builder: (context) => home) : CupertinoPageRoute(builder: (context) => home);
  }
}
