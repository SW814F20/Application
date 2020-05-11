import 'package:testEngine/src/Generator.dart';

abstract class CanGenerate{
  void accept(Generator visitor) => visitor.generate(this);
}