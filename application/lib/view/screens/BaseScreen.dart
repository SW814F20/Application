import 'package:flutter/cupertino.dart';

abstract class BaseScreen extends StatelessWidget {
  Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  bool isKeyboardShown(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  bool isInPortraitMode(BuildContext context) {
    return this.getOrientation(context) == Orientation.portrait;
  }

  bool isInLandscapemode(BuildContext context) {
    return this.getOrientation(context) == Orientation.landscape;
  }

  Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
