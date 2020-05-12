import 'package:testEngine/src/CodeGenerators/flutter/widgets/testWidgets.dart';
import 'package:testEngine/src/UIElements/Button.dart';

class FlutterButtonGenerator extends testWidgets{

  FlutterButtonGenerator(String title, List<String> lines, Set<String> imports):
        super(title: title, testContent: lines, imports: imports);

  static testWidgets build(ButtonElement element){
    var title = '${element.type} named ${element.name} should exists on page';
    var lines = <String>{};
    var imports = <String>{};

    imports.add('package:flutter/cupertino.dart');
    imports.add('package:flutter/material.dart');

    lines.add('final ${element.name}Widget = find.byKey(Key("${element.name}"));');
    lines.add('expect(${element.name}Widget, findsOneWidget);');
    lines.add('expect(${element.name}Widget.evaluate().first.widget, (item) {');
    lines.add('\treturn item is MaterialButton || item is CupertinoButton;');
    lines.add('});');

    if(element.text != null) {
      lines.add('expect(find.descendant(of: ${element.name}Widget, matching: find.text(\'${element.text}\')), findsOneWidget);');
    }

    return FlutterButtonGenerator(title, lines.toList(), imports);
  }
}