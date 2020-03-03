import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  Size getScreenSize() {
    return MediaQuery.of(this.context).size;
  }

  bool isKeyboardShown() {
    return MediaQuery.of(this.context).viewInsets.bottom > 0;
  }

  bool isInPortraitMode() {
    return this.getOrientation() == Orientation.portrait;
  }

  bool isInLandscapemode() {
    return this.getOrientation() == Orientation.landscape;
  }

  Orientation getOrientation() {
    return MediaQuery.of(context).orientation;
  }

  bool isTablet() {
    var size = MediaQuery.of(context).size;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));

    var isTablet = diagonal > 1100.0;
    return isTablet;
  }

  bool isPhone() {
    return !isTablet();
  }

  BuildContext context;

  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(appBar: appBar(), body: content());
  }

  Widget content() {
    return Container();
  }

  Widget appBar() {
    return Container();
  }
}
