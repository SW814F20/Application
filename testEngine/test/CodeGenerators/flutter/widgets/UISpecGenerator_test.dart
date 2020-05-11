import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';
import 'package:testEngine/src/CodeGenerators/flutter/UISpecGenerator.dart';
import 'package:testEngine/src/Generator.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';
import 'package:testEngine/testEngine.dart';

class MockGenerator extends Mock implements Generator{}

void main() {
  TextInputElement textEl;
  UISpec uiSpec;
  UISpecGenerator specGen;
  Generator mockGenerator;

  group('Flutter UISPec Generator Basic tests', (){
    setUp((){
      textEl = TextInputElement(name: 'textInput');
      uiSpec = UISpec(id: 1, name: 'UISpec', elements: [textEl]);
      mockGenerator = MockGenerator();
      specGen = UISpecGenerator(uiSpec, mockGenerator);
    });

    test('Should create a new document in OutputPackage', (){
      var package = OutputPackage(name: 'packageName');
      specGen.addToDocument(package);

      expect(package.files().length, 1);
      expect(package.files()[0].name,'UISpecWidgetTests');
    });
  });
}