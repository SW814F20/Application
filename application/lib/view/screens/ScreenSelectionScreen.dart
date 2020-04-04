import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/NewScreenScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes.dart';

class ScreenSelectionScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    contextObject.setOutput(context);
    return content();
  }

  @override
  Widget content() {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Screen Selector'),
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () => Routes.pop(contextObject.getOutput()),
          ),
          actions: <Widget>[
            createNewScreenButton(),
          ],
        ),
        body: Container(
          child: convertItemsToScreen(),
        ));
  }

  Widget convertItemsToScreen() {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text("Screen 1",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                child: Column(
                  children: convertScreenInfoToWidget(),
                ))
          ],
        ));
  }

  List<Widget> convertScreenInfoToWidget() {
    return [
      Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Text("hello"),
            Text("hello1"),
            Text("hello2"),
            FlatButton(onPressed: null, child: Text("Hello 231"))
          ],
        ),
      )
    ];
  }

  Widget createNewScreenButton() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.plus),
      onPressed: () =>
          {Routes.push(contextObject.getOutput(), NewScreenScreen())},
    );
  }
}
