import 'package:testEngine/src/UIElements/Text.dart';

import 'testWidgets.dart';

class FlutterTextGenerator extends testWidgets{

  FlutterTextGenerator(String title, List<String> lines, Set<String> imports):
        super(title: title, testContent: lines, imports: imports);

  static testWidgets build(TextElement element){
    var title = '${element.type} named ${element.name} should exists on page';
    var lines = <String>{};
    var imports = <String>{};

    lines.add('final ${element.name}Widget = find.byKey(Key("${element.name}"));');
    lines.add('expect(${element.name}Widget, findsOneWidget);');
    lines.add('final ${element.name}WidgetEval = ${element.name}Widget.evaluate().first.widget;');
    lines.add('expect(${element.name}WidgetEval, isA<Text>());');
    lines.add('expect((${element.name}WidgetEval as Text).data, "${element.data}");');

    return FlutterTextGenerator(title, lines.toList(), imports);
  }
}