import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/EditorScreenElement.dart';
import 'package:application/model/Screen.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenEditorScreen extends BaseScreen {
  ScreenEditorScreen(this.screen) {
    for (var widget in screen.screenContent) {
      screenContent.add(EditorScreenElement(
          type: widget['type'],
          textValue: widget['value'],
          key: widget['key']));
    }
  }

  final ScreenBloc screenBloc = di.getDependency<ScreenBloc>();

  final Screen screen;

  final List<EditorScreenElement> screenContent = [];

  final List<String> widgets = ['Text', 'Flat button', 'Label'];

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
                createWidgetConfigurationView()
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
            addElementToStream(type);
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

  Expanded createWidgetConfigurationView() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('Label Info')],
        ),
      ),
    );
  }

  SizedBox createScreenElements() {
    return SizedBox(
      height: screenContentHeight(),
      child: StreamBuilder<List<EditorScreenElement>>(
          stream: screenBloc.screensStream.stream,
          initialData: screenContent,
          builder: (BuildContext context,
              AsyncSnapshot<List<EditorScreenElement>> snapshot) {
            final List<Widget> content = [];
            for (var i = 0; i < snapshot.data.length; i++) {
              content.add(createScreenWidget(snapshot.data[i]));
            }
            return Column(children: content);
          }),
    );
  }

  Widget createScreenWidget(EditorScreenElement element) {
    return GestureDetector(
      child: Text(element.display()),
      onTap: () {
        print(element.textValue);
      },
    );
  }

  void addElementToStream(String type) {
    screenContent.add(EditorScreenElement(key: '', textValue: '', type: type));
    screenBloc.screensStream.sink.add(screenContent);
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

  Future<bool> updateScreen() async {
    final bool success = await screenBloc.updateScreen(
        screen.id, screen.screenName, screen.screenContent.toString());

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
