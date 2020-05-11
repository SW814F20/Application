import 'dart:convert';

import 'package:file/local.dart';
import 'package:testEngine/src/CodeGenerators/flutter/flutterTestGenerator.dart';
import 'package:testEngine/src/CodeGenerators/packageExporter.dart';
import 'package:testEngine/src/providers/sw814Api.dart';
import 'package:testEngine/testEngine.dart';

main() {
  var te = TestEngine();
  var fs = LocalFileSystem();
  var api = Sw814Api('https://sw814f20.lundsgaardkammersgaard.dk/');

  api.attemptLogin('Graatand', 'password').then((responds) {
    var token = responds['token'];
    api.getScreens(9, token).then((List<Map<String, dynamic>> screens) {
      for(var screen in screens) {
        var wrapper = <String, dynamic>{};
        wrapper['id'] = screen['id'];
        wrapper['name'] = screen['screenName'];
        wrapper['elements'] = screen['screenContent'];

        fs.currentDirectory = '/Users/mortenhartvigsen/Desktop/test-folder';
        var UIspec = te.parseLayoutFromJson(wrapper);
        var generator = FlutterTestGenerator(packageName: 'TestSuites');
        var exporter = PackageExporter(fs);
        UIspec.accept(generator);
        exporter.export(generator.package);

      }
    });
  });
}