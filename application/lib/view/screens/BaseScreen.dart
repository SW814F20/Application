import 'dart:math';

import 'package:application/model/Output.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  Size getScreenSize() {
    return MediaQuery.of(contextObject.getOutput()).size;
  }

  bool isKeyboardShown() {
    return MediaQuery.of(contextObject.getOutput()).viewInsets.bottom > 0;
  }

  bool isInPortraitMode() {
    return getOrientation() == Orientation.portrait;
  }

  bool isInLandscapemode() {
    return getOrientation() == Orientation.landscape;
  }

  Orientation getOrientation() {
    return MediaQuery.of(contextObject.getOutput()).orientation;
  }

  bool isTablet() {
    final Size size = MediaQuery.of(contextObject.getOutput()).size;
    final double diagonal = sqrt((size.width * size.width) + (size.height * size.height));

    final bool isTablet = diagonal > 1100.0;
    return isTablet;
  }

  double getScreenWidth() {
    return MediaQuery.of(contextObject.getOutput()).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(contextObject.getOutput()).size.height;
  }

  bool isPhone() {
    return !isTablet();
  }

  final Output<BuildContext> contextObject = Output<BuildContext>(null);

  @override
  Widget build(BuildContext context) {
    contextObject.setOutput(context);
    return Scaffold(appBar: appBar(), body: content());
  }

  Widget content() {
    return Container();
  }

  Widget appBar() {
    return Container();
  }
}
