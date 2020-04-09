import 'dart:convert';

import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Screen.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/NewScreenScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenSelectionScreen extends BaseScreen {
  ScreenSelectionScreen(this.application) {
    screenBloc
        .getScreens(application.id)
        .then((value) => value.forEach((element) {
              screens.add(element);
            }));
  }
  final ScreenBloc screenBloc = di.getDependency<ScreenBloc>();

  final Application application;

  int screensEachRowPortrait() => isTablet() ? 5 : 3;

  int screensEachRowLandscape() => isTablet() ? 7 : 5;

  double screenHeigth() => isTablet() ? 200 : 150;

  double screenWidth() => isTablet() ? 150 : 105;

  final List<Screen> screens = [];

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: getScreenRows(),
            ),
          ),
        ));
  }

  Column getScreenRows() {
    final List<List<Widget>> rows = [<Widget>[]];
    if (isInLandscapemode()) {
      int rowCount = 0;
      for (var i = 0; i < screens.length; i++) {
        if (i % screensEachRowLandscape() == 0 && i > 0) {
          rows.add(<Widget>[]);
          rowCount += 1;
        }
        rows[rowCount].add(createScreen(screens[0], i + 1));
      }
    } else if (isInPortraitMode()) {
      int rowCount = 0;
      for (var i = 0; i < screens.length; i++) {
        if (i % screensEachRowPortrait() == 0 && i > 0) {
          rows.add(<Widget>[]);
          rowCount += 1;
        }
        rows[rowCount].add(createScreen(screens[0], i + 1));

      }
    }
    final List<Widget> outputRows = <Widget>[];
    for (List<Widget> element in rows) {
      outputRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: element,
      ));
    }

    final Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: outputRows,
    );

    return column;
  }

  Widget createScreen(Screen screen, int position) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text('Screen ' + position.toString(),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                child: Column(
                  children: <Widget>[createScreenInfoToWidgets(screen)],
                ))
          ],
        ));
  }

  // We need to add more widgets in this method.
  Widget createWidgetFromType(Map<String, dynamic> widget) {
    switch (widget['type'].toString().toLowerCase()) {
      case 'text':
        return Text(widget['value']);
      case 'flatbutton':
        return FlatButton(onPressed: null, child: Text(widget['value']));
      default:
        throw Exception('Widget not found. Either add it or ensure no typos');
    }
  }

  Widget createScreenInfoToWidgets(Screen screen) {
    final List<Widget> screenInfo = [];
    for (var i = 0; i < screen.screenContent.length; i++) {
      screenInfo.add(createWidgetFromType(screen.screenContent[i]));
    }

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      height: screenHeigth(),
      width: screenWidth(),
      child: Column(children: screenInfo),
    );
  }

  Widget createNewScreenButton() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.plus),
      onPressed: () =>
          {Routes.push(contextObject.getOutput(), NewScreenScreen())},
    );
  }
}
