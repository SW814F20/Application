import 'package:testEngine/src/CodeGenerators/CanOutputToDocument.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';
import 'package:testEngine/src/Generator.dart';
import 'package:testEngine/src/UISpec.dart';

class UISpecGenerator implements CanOutputToDocument{
  final UISpec element;
  final Generator generator;
  String methodName;

  UISpecGenerator(this.element, this.generator){
    methodName = '${_asMethodName(element.name)}';
  }

  @override
  void addToDocument(OutputPackage package) {
    package.newDocument(methodName + 'WidgetTests');
    package.addRunner(methodName, 'run${methodName}Tests');
    package.addHelperSignature('Widget get${methodName}Widget();');
    package.addImport('package:flutter_test/flutter_test.dart');
    package.addImport('${package.fileName}.dart');
    package.add('void run${methodName}Tests(${package.name} helpers) {');
    package.newline();
    package.indent();
    package.add('pumpScreen(WidgetTester tester){');
    package.newline();
    package.indent();
    package.add('return tester.pumpWidget(helpers.get${methodName}Widget());');
    package.newline();
    package.outdent();
    package.add('}');
    package.newline();
    package.add('group(\'${element.name} UI elements tests\', () {');
    package.newline();

    for(var item in element.elements){
      item.accept(generator);
    }

    package.add('});');
    package.newline();
    package.outdent();
    package.add('}');
  }

  String _asMethodName(String item){
    var res = item.replaceAll(' ', '');
    res = res.replaceAll('-', '');
    return res;
  }
}