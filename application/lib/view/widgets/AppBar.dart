import 'package:application/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({this.centerTitle = false, this.title = 'No title'});
  final bool centerTitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(title),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
