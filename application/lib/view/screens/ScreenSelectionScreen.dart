import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Screen.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/NewScreenScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../routes.dart';

class ScreenSelectionScreen extends BaseScreen {
  ScreenSelectionScreen(this.application) {
    screenBloc.getScreens(application.id).then((value) => value.forEach((element) {
          screens.add(element);
        }));
  }
  final ScreenBloc screenBloc = di.getDependency<ScreenBloc>();

  final Application application;

  int screensEachRowPortrait() => isTablet() ? 3 : 3;

  int screensEachRowLandscape() => isTablet() ? 5 : 6;

  final List<Screen> screens = [];

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
            child: Container(
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
        rows[rowCount].add(createScreen(screens[i]));
      }
    } else if (isInPortraitMode()) {
      int rowCount = 0;
      for (var i = 0; i < screens.length; i++) {
        if (i % screensEachRowPortrait() == 0 && i > 0) {
          rows.add(<Widget>[]);
          rowCount += 1;
        }
        rows[rowCount].add(createScreen(screens[i]));
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

  Widget createScreen(Screen screen) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text('Screen ' + screen.id.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ),
            Container(
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                child: Column(
                  children: <Widget>[createScreenInfoToWidgets(screen)],
                ))
          ],
        ));
  }

  Widget createScreenInfoToWidgets(Screen screen) {
    final List<Widget> screenInfo = [];
    /*
    for (var widget in screen.screenContent) {
      if (widget == 'Text') {
        screenInfo.add(const Text('hello'));
      } else if (widget == 'Flatbutton') {
        screenInfo.add(const FlatButton(onPressed: null, child: Text('hel')));
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      height: 150,
      width: 105,
      child: Column(children: screenInfo),
    );
          */
  }

  Widget createNewScreenButton() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.plus),
      onPressed: () => {Routes.push(contextObject.getOutput(), NewScreenScreen())},
    );
  }
}
