import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/testWidgets.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';

class FlutterTextFieldGenerator extends testWidgets{

  FlutterTextFieldGenerator(String title, List<String> lines):
        super(title: title, testContent: lines, imports: null);

  static testWidgets build(TextInputElement element){
    var title = '${element.type} named ${element.name} should exists on page';
    var lines = <String>{};

    lines.add('final ${element.name}Widget = find.byKey(Key("${element.name}"));');
    lines.add('expect(${element.name}Widget, findsOneWidget);');
    lines.add('final ${element.name}WidgetEval = ${element.name}Widget.evaluate().first.widget;');
    lines.add('expect(${element.name}WidgetEval, isA<TextField>());');
    lines.add('expect((${element.name}WidgetEval as TextField).obscureText, ${trueOrFalse(element.obscureText)});');
    lines.add('expect((${element.name}WidgetEval as TextField).autocorrect, ${trueOrFalse(element.autoCorrect)});');
    lines.add('expect((${element.name}WidgetEval as TextField).readOnly, ${trueOrFalse(element.readOnly)});');
    if(element.enabled == null){
      lines.add('expect((${element
          .name}WidgetEval as TextField).enabled, isNull);');
    } else {
      lines.add('expect((${element
          .name}WidgetEval as TextField).enabled, ${trueOrFalse(
          element.enabled)});');
    }
    lines.add('expect((${element.name}WidgetEval as TextField).enableSuggestions, ${trueOrFalse(element.enableSuggestions)});');

    return FlutterTextFieldGenerator(title, lines.toList());
  }

  static String trueOrFalse(bool val){
    return (val) ? 'isTrue' : 'isFalse';
  }
}