import 'package:file/file.dart';
import 'package:test/test.dart';
import 'package:file/memory.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';
import 'package:testEngine/src/CodeGenerators/packageExporter.dart';

void main(){
  group('Package exporter basics', (){
    FileSystem fs;
    OutputPackage package;

    setUp((){
      fs = MemoryFileSystem.test();
      package = OutputPackage(name: 'TestPackage');
    });

    test('Should create a folder with the package name', () async {
      var exporter = PackageExporter(fs);
      exporter.export(package);
      expect(await fs.isDirectory('/TestPackage'), isTrue);
    });

    test('Should provide the abstract adapter file', () async {
      var exporter = PackageExporter(fs);
      package.adapter = 'hello world!';
      exporter.export(package);
      expect(await fs.isFile('TestPackage/testPackage.dart'), isTrue, reason: 'The exporter do not create the adapter file');
      expect(await fs.file('TestPackage/testPackage.dart').readAsString(), 'hello world!');
    });

    test('should create a file for every document in package', () async {
      var exporter = PackageExporter(fs);
      package.newDocument('testDocument');
      package.add('hello world!');
      exporter.export(package);
      expect(await fs.isFile('TestPackage/testDocument.dart'), isTrue, reason: 'The exporter do not create the document file');
      expect(await fs.file('TestPackage/testDocument.dart').readAsString(), 'hello world!');
    });

  });
}