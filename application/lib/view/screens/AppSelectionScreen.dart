import 'package:application/blocs/ApplicationBloc.dart';
import 'package:application/blocs/AuthenticationBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Output.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/DashboardScreen.dart';
import 'package:application/view/screens/NewAppScreen.dart';
import 'package:application/view/widgets/ConfirmDIalog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSelectionScreen extends BaseScreen {
  AppSelectionScreen(this.apps);

  final AuthenticationBloc authenticationBloc =
      di.getDependency<AuthenticationBloc>();
  final ApplicationBloc applicationBloc = di.getDependency<ApplicationBloc>();

  final Output<List<Application>> apps;

  int appsEachRowPortrait() => isTablet() ? 3 : 3;

  int appsEachRowLandscape() => isTablet() ? 5 : 6;

  double appCircleSize() => appContainerSize() * 0.8;

  double appContainerSize() => isInLandscapemode()
      ? (getScreenWidth() * 0.9 - (8 * appsEachRowLandscape())) /
          appsEachRowLandscape()
      : (getScreenWidth() * 0.9 - (8 * appsEachRowPortrait())) /
          appsEachRowPortrait();

  @override
  Widget build(BuildContext context) {
    applicationBloc.getApplications().then((value) => apps.setOutput(value));
    return WillPopScope(
        onWillPop: () async {
          logoutConfirm();
          return true;
        },
        child: super.build(context));
  }

  @override
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Select Application'),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.lock),
        onPressed: () => logoutConfirm(),
      ),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.plus),
          onPressed: () =>
              {Routes.push(contextObject.getOutput(), NewAppScreen())},
        ),
      ],
    );
  }

  @override
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
            onTap: () => {
              Routes.push(
                  contextObject.getOutput(), DashboardScreen(application))
            },
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
                          getAvatarString(application.appName, application.id),
                          style: const TextStyle(fontSize: 46),
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

  String getAvatarString(String appName, int appId) {
    final List<String> strings = appName.split(' ');
    if (strings.length == 1) {
      return strings[0].substring(0, 2).toUpperCase() + '-' + appId.toString();
    } else if (strings.length >= 2) {
      return strings[0].substring(0, 1).toUpperCase() +
          strings[1].substring(0, 1).toUpperCase()+ '-' + appId.toString();;
    } else {
      return '-';
    }
  }

  Column getAppRows() {
    final List<List<Widget>> rows = [<Widget>[]];
    if (isInLandscapemode()) {
      int rowCount = 0;
      for (var i = 0; i < apps.getOutput().length; i++) {
        if (i % appsEachRowLandscape() == 0 && i > 0) {
          rows.add(<Widget>[]);
          rowCount += 1;
        }
        rows[rowCount].add(getAppSelectionOption(apps.getOutput()[i]));
      }
    } else if (isInPortraitMode()) {
      int rowCount = 0;
      for (var i = 0; i < apps.getOutput().length; i++) {
        if (i % appsEachRowPortrait() == 0 && i > 0) {
          rows.add(<Widget>[]);
          rowCount += 1;
        }
        rows[rowCount].add(getAppSelectionOption(apps.getOutput()[i]));
      }
    }
    final List<Widget> outputRows = <Widget>[];
    for (List<Widget> element in rows) {
      outputRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: element,
      ));
    }

    final Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: outputRows,
    );

    return column;
  }

  void logoutConfirm() {
    showDialog<Center>(
        barrierDismissible: false,
        context: contextObject.getOutput(),
        builder: (BuildContext context) {
          return ConfirmDialog(
            title: 'Logout',
            description: 'Are you sure you want to logout?',
            key: const Key('LogoutConfirmDialogKey'),
            functionAbort: () => <void>{},
            functionConfirm: () => {Routes.reset(contextObject.getOutput())},
            confirmIcon: FaIcon(FontAwesomeIcons.lock),
            abortIcon: FaIcon(FontAwesomeIcons.arrowRight),
          );
        });
  }
}
