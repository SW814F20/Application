import 'package:application/view/widgets/ButtonWidget.dart';
import 'package:application/view/widgets/TitleHeader.dart';
import 'package:flutter/material.dart';
import 'package:application/routes.dart';

class NotifyDialog extends StatelessWidget implements PreferredSizeWidget {
  const NotifyDialog({Key key, @required this.title, this.description, this.function}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  final String title;

  final String description;

  final Function function;

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
                    key: const Key('NotifyDialogOkayButton'),
                    text: 'Okay',
                    icon: const ImageIcon(
                      AssetImage('assets/placeholder/placeholder.png'),
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    onPressed: () {
                      Routes.pop(context);
                      function();
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}
