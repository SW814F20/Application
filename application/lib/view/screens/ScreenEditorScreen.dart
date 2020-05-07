import 'dart:async';

import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/EditorScreenElement.dart';
import 'package:application/model/Screen.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/configurationScreen.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenEditorScreen extends BaseScreen {
  ScreenEditorScreen(this.screen);

  final ScreenBloc screenBloc = di.getDependency<ScreenBloc>();

  final Screen screen;

  List<EditorScreenElement> get screenContent => screen.screenContent;

  final List<String> widgets = ['Text', 'Button', 'TextInput'];

  double widgetListWidth() => isTablet() ? 200 : 110;
  double screenContentHeight() => getScreenHeight() / 2.2;

  @override
  Widget content() {
    return Row(
      children: <Widget>[
        createWidgetList(),
        Expanded(
          child: Container(
            child: Column(
              children: <Widget>[
                createScreenElements(),
              ],
            ),
          ),
        )
      ],
    );
  }

  SizedBox createWidgetList() {
    final List<Widget> listOfWidgets = [];

    for (var type in widgets) {
      listOfWidgets.add(
        GestureDetector(
          onTap: () {
            addElementToScreenStream(type);
          },
          child: Text(
            type,
          ),
        ),
      );
      listOfWidgets.add(
        const SizedBox(
          height: 8,
        ),
      );
    }

    return SizedBox(
      child: Container(
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listOfWidgets,
              ),
            ),
            decoration: BoxDecoration(color: Colors.grey)),
      ),
      width: widgetListWidth(),
    );
  }

  Widget createScreenElements() {
    return StreamBuilder<List<EditorScreenElement>>(
        stream: screenBloc.editorScreenStream.stream,
        initialData: screenContent,
        builder: (BuildContext context,
            AsyncSnapshot<List<EditorScreenElement>> snapshot) {
          final List<Widget> content = [];
          for (var widget in snapshot.data) {
            content.add(createScreenWidget(widget));
            content.add(
              const SizedBox(
                height: 16,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(children: content),
          );
        });
  }

  Widget createScreenWidget(EditorScreenElement element) {
    return GestureDetector(
      child: Text(element.display()),
      onTap: () => Routes.push(
          contextObject.getOutput(),
          ConfigurationScreen(
            element: element,
          )),
    );
  }

  void addElementToScreenStream(String type) {
    screenContent.add(EditorScreenElement.create(type, screenContent.length));
    screenBloc.editorScreenStream.sink.add(screenContent);
  }

  @override
  Widget appBar() {
    return AppBar(
        title: Text('Screen editor for: ' + screen.screenName),
        centerTitle: true,
        actions: <Widget>[
          updateScreenButton(),
        ],
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Routes.pop(contextObject.getOutput()),
        ));
  }

  Widget updateScreenButton() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.upload),
      onPressed: () => updateScreen(),
    );
  }

  String rewriteToNormalForm() {
    String result = '[';
    for (var i = 0; i < screenContent.length; i++) {
      result += screenContent[i].toJson();
      if (i != screenContent.length - 1) {
        result += ',';
      }
    }
    result += ']';
    return result.replaceAll('\n', ' ');
  }

  Future<bool> updateScreen() async {
    final bool success = await screenBloc.updateScreen(
        screen.id, screen.screenName, rewriteToNormalForm());

    if (success) {
      // Screen updated successful
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return NotifyDialog(
              title: 'Success',
              description: 'Screen updated successfuly!',
              key: const Key('ScreenUpdated'),
              function: () => {Routes.pop(contextObject.getOutput())},
            );
          });
      return true;
    } else {
      // Server error
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return const NotifyDialog(
                title: 'Server Error',
                description: 'Screen update refused',
                key: Key('ServerError'));
          });
      return false;
    }
  }
}
