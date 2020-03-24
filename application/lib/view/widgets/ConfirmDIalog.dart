import 'package:application/view/widgets/ButtonWidget.dart';
import 'package:application/view/widgets/TitleHeader.dart';
import 'package:flutter/material.dart';
import 'package:application/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmDialog extends StatelessWidget implements PreferredSizeWidget {
  const ConfirmDialog({
    Key key,
    @required this.title,
    this.description,
    this.functionConfirm,
    this.functionAbort,
    this.confirmText = 'Yes',
    this.abortText = 'No',
    this.abortIcon,
    this.confirmIcon,
  }) : super(key: key);

  final String confirmText;
  final String abortText;

  final FaIcon abortIcon;
  final FaIcon confirmIcon;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  final String title;

  final String description;

  final Function functionConfirm;
  final Function functionAbort;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      titlePadding: const EdgeInsets.all(0.0),
      shape: Border.all(color: const Color.fromRGBO(112, 112, 112, 1), width: 5.0),
      title: Center(
          child: TitleHeader(
        title: title,
      )),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  //if description is null, its replaced with empty.
                  description ?? '',
                  textAlign: TextAlign.center,
                ),
              ))
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Button(
                    key: const Key('NotifyDialogConfirmButton'),
                    text: confirmText,
                    icon: confirmIcon,
                    onPressed: () {
                      Routes.pop(context);
                      functionConfirm();
                    },
                  ),
                  Button(
                    key: const Key('NotifyDialogAbourtButton'),
                    text: abortText,
                    icon: abortIcon,
                    onPressed: () {
                      Routes.pop(context);
                      functionAbort();
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}
