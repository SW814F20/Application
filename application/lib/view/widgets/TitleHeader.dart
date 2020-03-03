import 'package:flutter/material.dart';

/// The GirafDialogHeader is to be used at the title location of widgets
class TitleHeader extends StatelessWidget implements PreferredSizeWidget {
  ///The header takes the title as input, so it is similar for all titles.
  const TitleHeader({Key key, this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  ///title of the header
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Center(
                  child: Text(
                title ?? '',
                textAlign: TextAlign.center,
              )),
            ),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: <double>[
                  0.33,
                  0.66
                ],
                    colors: <Color>[
                  Color.fromRGBO(254, 215, 108, 1),
                  Color.fromRGBO(253, 187, 85, 1),
                ])),
          ),
        ),
      ],
    );
  }
}
