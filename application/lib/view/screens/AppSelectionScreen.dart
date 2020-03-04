import 'package:application/blocs/ApplicationBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/User.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/NewAppScreen.dart';
import 'package:application/view/screens/TasksScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class AppSelectionScreen extends BaseScreen {
  AppSelectionScreen(this.loggedInUser);

  final ApplicationBloc applicationBloc = di.getDependency<ApplicationBloc>();

  List<Application> apps() => applicationBloc.data;

  final User loggedInUser;

  int appsEachRowPortrait() => this.isTablet() ? 3 : 3;

  int appsEachRowLandscape() => this.isTablet() ? 5 : 6;

  double appCircleSize() => appContainerSize() * 0.8;

  double appContainerSize() => this.isInLandscapemode()
      ? (this.getScreenWidth() * 0.9 - (8 * this.appsEachRowLandscape())) /
          this.appsEachRowLandscape()
      : (this.getScreenWidth() * 0.9 - (8 * this.appsEachRowPortrait())) /
          this.appsEachRowPortrait();

  @override
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Select Application"),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.lock),
        onPressed: () => Routes.reset(this.context),
      ),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.plus),
          onPressed: () => {Routes.push(context, new NewAppScreen())},
        ),
      ],
    );
  }

  Widget content() {
    return Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(child: getAppRows()),
        ),
      ),
    );
  }

  Widget getAppSelectionOption(Application application) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: GestureDetector(
            onTap: () =>
                {Routes.push(this.context, new TaskScreen(application))},
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
                        backgroundColor: application.color,
                        child: Text(
                          getAvatarString(application.appName),
                          style: TextStyle(fontSize: 46),
                        ),
                      ),
                    ),
                    AutoSizeText(
                      application.appName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
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

  String getAvatarString(String appName) {
    List<String> strings = appName.split(" ");
    if (strings.length == 1) {
      return strings[0].substring(0, 2).toUpperCase();
    } else if (strings.length >= 2) {
      return strings[0].substring(0, 1).toUpperCase() +
          strings[1].substring(0, 1).toUpperCase();
    } else {
      return "-";
    }
  }

  Column getAppRows() {
    List<List<Widget>> rows = [new List<Widget>()];
    if (this.isInLandscapemode()) {
      int rowCount = 0;
      for (var i = 0; i < apps().length; i++) {
        if (i % appsEachRowLandscape() == 0 && i > 0) {
          rows.add(new List<Widget>());
          rowCount += 1;
        }
        rows[rowCount].add(getAppSelectionOption(apps()[i]));
      }
    } else if (this.isInPortraitMode()) {
      int rowCount = 0;
      for (var i = 0; i < apps().length; i++) {
        if (i % appsEachRowPortrait() == 0 && i > 0) {
          rows.add(new List<Widget>());
          rowCount += 1;
        }
        rows[rowCount].add(getAppSelectionOption(apps()[i]));
      }
    }
    List<Widget> outputRows = new List<Widget>();
    for (List<Widget> element in rows) {
      outputRows.add(new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: element,
      ));
    }

    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: outputRows,
    );

    return column;
  }
}
