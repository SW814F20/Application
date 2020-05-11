import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/flutter/flutterTestGenerator.dart';
import 'package:testEngine/src/Generator.dart';

void main() {
  Generator generator;

  setUp((){
    generator = FlutterTestGenerator();
  });

  group('Flutter widgetsTest Generator basic', () {
    
  });
}