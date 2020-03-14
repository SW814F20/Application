import 'dart:math';

import 'package:application/model/Output.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  Size getScreenSize() {
    return MediaQuery.of(this.contextObject.getOutput()).size;
  }

  bool isKeyboardShown() {
    return MediaQuery.of(this.contextObject.getOutput()).viewInsets.bottom > 0;
  }

  bool isInPortraitMode() {
    return this.getOrientation() == Orientation.portrait;
  }

  bool isInLandscapemode() {
    return this.getOrientation() == Orientation.landscape;
  }

  Orientation getOrientation() {
    return MediaQuery.of(this.contextObject.getOutput()).orientation;
  }

  bool isTablet() {
    var size = MediaQuery.of(this.contextObject.getOutput()).size;
    var diagonal = sqrt((size.width * size.width) + (size.height * size.height));

    var isTablet = diagonal > 1100.0;
    return isTablet;
  }

  double getScreenWidth() {
    return MediaQuery.of(this.contextObject.getOutput()).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(this.contextObject.getOutput()).size.height;
  }

  bool isPhone() {
    return !isTablet();
  }

  final Output<BuildContext> contextObject = new Output<BuildContext>(null);

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
