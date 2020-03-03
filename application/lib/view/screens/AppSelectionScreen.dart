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

class AppSelectionScreen extends BaseScreen {
  AppSelectionScreen(this.loggedInUser);

  final ApplicationBloc applicationBloc = di.getDependency<ApplicationBloc>();

  List<Application> apps() => applicationBloc.data;

  User loggedInUser;

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(child: getAppRows()),
        ),
      ),
    );
  }

  Widget getAppSelectionOption(Application application) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: GestureDetector(
          onTap: () => {Routes.push(this.context, new TaskScreen(application))},
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor: application.color,
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
    ));
  }

  Column getAppRows() {
    int appsEachRowPortrait = this.isTablet() ? 7 : 3;
    int appsEachRowLandscape = this.isTablet() ? 10 : 6;

    List<List<Widget>> rows = [new List<Widget>()];
    if (this.isInLandscapemode()) {
      int rowCount = 0;
      for (var i = 0; i < apps().length; i++) {
        if (i % appsEachRowLandscape == 0 && i > 0) {
          rows.add(new List<Widget>());
          rowCount += 1;
        }
        rows[rowCount].add(getAppSelectionOption(apps()[i]));
      }
    } else if (this.isInPortraitMode()) {
      int rowCount = 0;
      for (var i = 0; i < apps().length; i++) {
        if (i % appsEachRowPortrait == 0 && i > 0) {
          rows.add(new List<Widget>());
          rowCount += 1;
        }
        rows[rowCount].add(getAppSelectionOption(apps()[i]));
      }
    }
    List<Widget> outputRows = new List<Widget>();
    for (List<Widget> element in rows) {
      outputRows.add(new Row(
        children: element,
      ));
    }

    Column column = Column(
      children: outputRows,
    );

    return column;
  }
}
