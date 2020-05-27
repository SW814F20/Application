import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/CanOutputToDocument.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/testWidgets.dart';
import 'package:mockito/mockito.dart';

class mockWidget extends testWidgets{
  mockWidget(): super(title: 'Hello', testContent: <String>{
    'this is',
    'a test'
  }.toList());
}

class mockDocument extends Mock implements OutputPackage{}

void main(){
  CanOutputToDocument widget;
  OutputPackage doc;

  setUp((){
    widget = mockWidget();
    doc = mockDocument();
    widget.addToDocument(doc);
  });

  group('Abstract testWidget for flutter basics', () {
    test('Should call indent exactly 2 times', (){
        verify(doc.indent()).called(2);
    });

    test('Should call add exactly 5 times', () {
      verify(doc.add(any)).called(5);
    });

    test('Should call newline exactly 3 times', () {
      verify(doc.newline()).called(5);
    });

    test('Should call outdent exactly 2 times', (){
      verify(doc.outdent()).called(2);
    });

    test('Should call the OutputDocument in correct order and with correct data', () {
      verifyInOrder([
        doc.indent(),
        doc.add('testWidgets(\'Hello\', (WidgetTester tester) async {'),
        doc.newline(),
        doc.indent(),
        doc.add('await pumpScreen(tester);'),
        doc.newline(),
        // The loop of testContent
        doc.add('this is'),
        doc.newline(),
        doc.add('a test'),
        doc.newline(),
        //end of loop
        doc.outdent(),
        doc.add('});'),
        doc.newline(),
        doc.outdent(),
      ]);
    });
  });
}