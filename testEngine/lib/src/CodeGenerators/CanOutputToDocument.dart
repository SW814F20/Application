import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';

abstract class CanOutputToDocument{
  void addToDocument(OutputPackage doc);
}