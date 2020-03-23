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
            onPressed: () => <void>{},
            text: 'Test button',
            isEnabled: true,
          ),
          const Text('This is a placeholder screen!'),
        ],
      ),
    );
  }

  @override
  Widget appBar() {
    return AppBar(
        title: const Text('Placeholder screen'),
        centerTitle: true,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Routes.pop(contextObject.getOutput()),
        ));
  }
}
