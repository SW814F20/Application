import 'package:file/file.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';

class PackageExporter{
  final FileSystem fs;

  PackageExporter(this.fs);

  void export(OutputPackage package) {
    _generateThePackageFolder(package);
    _generateAdapterClass(package);
    for(var doc in package.files()){
      _generateDocument(package.name, doc);
    }
  }

  void _generateThePackageFolder(OutputPackage package){
    fs.directory(package.name).create();
  }

  void _generateAdapterClass(OutputPackage package) {
    var adapterFile = fs.file('${package.name}/${package.fileName}.dart');
    adapterFile.writeAsString(package.adapter).then((file) {
      file.create();
    });
  }

  void _generateDocument(String directory, Document document){
    var doc = fs.file('${directory}/${document.fileName}.dart');
    doc.writeAsString(document.content).then((file){
      file.create();
    });
  }

}