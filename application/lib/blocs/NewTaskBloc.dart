import 'dart:async';
import 'package:application/model/Screen.dart';

class NewTaskBloc {
  final StreamController<Screen> newScreensStream  = StreamController<Screen>.broadcast();
}