import 'package:testEngine/src/CodeGenerators/CanOutputToDocument.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';

abstract class testWidgets implements CanOutputToDocument {
  final String title;
  final List<String> testContent;
  Set<String> imports;

  testWidgets({this.title, this.testContent, this.imports});

  @override
  void addToDocument(OutputPackage doc) {
    doc.addImport('package:flutter_test/flutter_test.dart');
    if(imports != null){
      for(var import in imports){
        doc.addImport(import);
      }
    }
    doc.indent();
    doc.add('testWidgets(\'${title}\', (WidgetTester tester) async {');
    doc.newline();
    doc.indent();
    doc.add('await pumpScreen(tester);');
    doc.newline();

    for(var test in testContent){
      doc.add(test);
      doc.newline();
    }

    doc.outdent();
    doc.add('});');
    doc.newline();
    doc.outdent();
  }
}