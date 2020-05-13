import 'package:application/blocs/TaskBloc.dart';
import 'package:application/model/Application.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/ScreenSelectionScreen.dart';
import 'package:application/view/screens/TasksScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends BaseScreen {
  DashboardScreen(this.selectedApplication);

  final Application selectedApplication;

  int appsEachRowPortrait() => isTablet() ? 3 : 3;

  int appsEachRowLandscape() => isTablet() ? 5 : 6;

  double appCircleSize() => appContainerSize() * 0.8;

  double appContainerSize() => isInLandscapemode()
      ? (getScreenWidth() * 0.9 - (8 * appsEachRowLandscape())) / appsEachRowLandscape()
      : (getScreenWidth() * 0.9 - (8 * appsEachRowPortrait())) / appsEachRowPortrait();


  @override
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Dashboard Screen - ' + selectedApplication.appName),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(contextObject.getOutput()),
      ),
    );
  }

  @override
  Widget content() {
    return Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
              child: Row(
            children: <Widget>[
              getOption('Show screens', ScreenSelectionScreen(selectedApplication), Colors.green , 'SC'),
              getOption('Show tasks', TaskScreen(selectedApplication, TaskBloc(selectedApplication)), Colors.blue, 'TA'),
            ],
          )),
        ),
      ),
    );
  }



  Widget getOption(String name, BaseScreen nextScreen, Color circleColor, String avatarString) {
    return Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: GestureDetector(
                onTap: () => {Routes.push(contextObject.getOutput(), nextScreen)},
                child: Center(
                  child: Container(
                    height: appContainerSize(),
                    width: appContainerSize(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: appCircleSize(),
                          height: appCircleSize(),
                          child: CircleAvatar(
                            backgroundColor: circleColor,
                            child: Text(
                              avatarString,
                              style: const TextStyle(fontSize: 46),
                            ),
                          ),
                        ),
                        AutoSizeText(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          minFontSize: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }


}
