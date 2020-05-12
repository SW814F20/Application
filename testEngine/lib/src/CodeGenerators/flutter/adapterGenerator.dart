import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';

class FlutterAdapterGenerator{

  static String generate(OutputPackage package){
    var output = 'import \'package:flutter/widgets.dart\';\n\n';
    output += _importEachTestfile(package)+'\n';

    output += 'abstract class ${package.name} {\n';

    output += _getHelperMethods(package);
    output += '\n';
    output += _getRunner(package);

    output += '\n}';

    return output;
  }

  static String _getRunner(OutputPackage package) {
    var runner = '\tvoid run() {\n';

    for(var r in package.runners.entries){
      runner += '\t\t${r.value}(this);\n';
    }

    runner += '\t}';

    return runner;
  }

  static String _getHelperMethods(OutputPackage package) {
    var helpers = '';

    var sortedHelpers = package.helpers.toList();
    sortedHelpers.sort();
    for (var signature in sortedHelpers) {
      helpers += '\t'+signature+'\n';
    }

    return helpers;
  }

  static String _importEachTestfile(OutputPackage package){
    var output = '';

    for(var doc in package.files()){
      output += 'import \'${doc.fileName}.dart\';\n';
    }

    return output;
  }

}