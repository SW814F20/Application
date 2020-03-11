import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/PrimaryButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaceholderScreen extends BaseScreen {
  @override
  Widget content() {
    return Container(
      child: Column(
        children: <Widget>[
          PrimaryButton(
            onPressed: () => {},
            text: "Test button",
            isEnabled: true,
          ),
          Text("This is a placeholder screen!"),
        ],
      ),
    );
  }

  @override
  Widget appBar() {
    return new AppBar(
        title: Text("Placeholder screen"),
        centerTitle: true,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Routes.pop(this.contextObject.getOutput()),
        ));
  }
}
