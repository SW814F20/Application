import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Screen.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenEditorScreen extends BaseScreen {
  ScreenEditorScreen(this.screen);

  final ScreenBloc screenBloc = di.getDependency<ScreenBloc>();

  final Screen screen;

  @override
  Widget content() {
    return Container(
      child: Column(
        children: const <Widget>[
          Text('THIS IS WHERE WE NEED THE EDITOR'),
        ],
      ),
    );
  }

  @override
  Widget appBar() {
    return AppBar(
        title: Text('Screen editor for' + screen.screenName),
        centerTitle: true,
        actions: <Widget>[
          createSaveScreenButton(),
        ],
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Routes.pop(contextObject.getOutput()),
        ));
  }

  Widget createSaveScreenButton() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.upload),
      onPressed: () => createScreen(),
    );
  }

  Future<bool> createScreen() async {
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
