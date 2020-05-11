import 'package:testEngine/src/CanGenerate.dart';
import 'package:testEngine/src/CodeGenerators/flutter/UISpecGenerator.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/Button.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/Text.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/TextField.dart';
import 'package:testEngine/src/Generator.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';
import 'package:testEngine/src/UIElements/Button.dart';
import 'package:testEngine/src/UIElements/Text.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';
import 'package:testEngine/src/UISpec.dart';

import 'adapterGenerator.dart';

class FlutterTestGenerator extends Generator{
  OutputPackage _package;

  FlutterTestGenerator({String packageName}){
    _package = OutputPackage(name: packageName);
  }

  OutputPackage get package {
    _package.adapter =  FlutterAdapterGenerator.generate(_package);
    return _package;
  }

  @override
  void generate(CanGenerate item) {
    if(item is UISpec) {
      _package.addTest(UISpecGenerator(item, this));
    } else if(item is TextInputElement) {
      _package.addTest(FlutterTextFieldGenerator.build(item));
    } else if(item is ButtonElement) {
      _package.addTest(FlutterButtonGenerator.build(item));
    } else if (item is TextElement){
      _package.addTest(FlutterTextGenerator.build(item));
    }else{
      throw ArgumentError('No code generator available for item!');
    }
  }
}