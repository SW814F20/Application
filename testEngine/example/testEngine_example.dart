/*
 * This is the example of how to use this package, in this example we use the
 * the code generator build into the package (FlutterTestGenerator) - although
 * you are able to inject your own as long as it implements the Generator abstract
 * class in the package.
 *
 * This example also showcases how to use the API feature for use with the Mobile
 * application for requirement creation. The package is not limited to this, as
 * long as it is supplied with the correct JSON format the package will work.
 */

import 'package:file/local.dart';
import 'package:testEngine/src/CodeGenerators/flutter/flutterTestGenerator.dart';
import 'package:testEngine/src/CodeGenerators/packageExporter.dart';
import 'package:testEngine/src/providers/sw814Api.dart';
import 'package:testEngine/testEngine.dart';

main() {
  var te = TestEngine(); // A new instance of the test engine
  var fs = LocalFileSystem(); // A instance of the file system abstraction
  fs.currentDirectory = '/Users/mortenhartvigsen/Desktop/test-folder'; // Set the output path of the package
  var api = Sw814Api('https://sw814f20.lundsgaardkammersgaard.dk/'); // A instance of the built in api.
  var generator = FlutterTestGenerator(packageName: 'TestSuites'); // The code generator instance
  var exporter = PackageExporter(fs); // Instance of the exporter

  // Attempt to login to the API
  api.attemptLogin('Graatand', 'password').then((responds) {
    //If login is success, store the token.
    var token = responds['token'];

    // Get all screens belonging to app with id 9
    api.getScreens(9, token).then((List<Map<String, dynamic>> screens) {
      // Loop over all screens
      for(var screen in screens) {
        // Converting the data structure from the API response into the package structure.
        var wrapper = <String, dynamic>{};
        wrapper['id'] = screen['id'];
        wrapper['name'] = screen['screenName'];
        wrapper['elements'] = screen['screenContent'];

        // Tokenize the json response.
        var UIspec = te.parseLayoutFromJson(wrapper);

        // Use the code generator to generate the target code.
        UIspec.accept(generator);
      }

      // Export the entire code base to the file system.
      exporter.export(generator.package);
    });
  });
}