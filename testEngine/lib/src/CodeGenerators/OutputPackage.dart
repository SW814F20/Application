import 'package:testEngine/src/CodeGenerators/CanOutputToDocument.dart';

class Document{
  final String name;
  final Set<String> imports = <String>{};
  String _content = '';

  Document({this.name});

  String get fileName {
    return name[0].toLowerCase() + name.substring(1);
  }

  void add(String data){
    _content += data;
  }

  String get content {
    var importsString = '';
    if(imports.isNotEmpty){
      var sortedImports = imports.toList();
      sortedImports.sort();
      for(var import in sortedImports){
        importsString += 'import \''+import+'\';\n';
      }
      importsString += '\n\n';
    }

    return importsString+_content;
  }
}

class OutputPackage{
  final Map<String, Document> _documents = <String, Document>{};
  Document _currentDoc;
  int _tabIndex = 0;
  final String name;
  final Map<String, String> runners = <String, String>{};
  final Set<String> helpers = <String>{};
  String adapter = '';

  OutputPackage({this.name});

  String get fileName {
    return name[0].toLowerCase() + name.substring(1);
  }

  void addRunner(String fileName, String methodName) {
    if(!runners.containsKey(fileName)){
      runners[fileName] = methodName;
    }else{
      throw ArgumentError('A runner is already registered for the file \'${fileName}\'!');
    }
  }

  void addHelperSignature(String signature) {
    if(signature[signature.length-1] != ';'){
      signature += ';';
    }
    helpers.add(signature);
  }

  void newDocument(String documentName) {
    if(!_documents.containsKey(documentName)){
      _documents[documentName] = Document(name: documentName);
    }

    resetIndent();
    _currentDoc = _documents[documentName];
  }

  void switchDocument(String documentName) {
    if(_documents.containsKey(documentName)){
      resetIndent();
      _currentDoc = _documents[documentName];
    }else {
      throw ArgumentError("No document found named '${documentName}'!");
    }
  }

  Document getDocument(String documentName){
    return _documents[documentName];
  }

  List<Document> files() {
    return _documents.values.toList();
  }

  void add(String data){
    if(_currentDoc == null){
      throw UnsupportedError("You cant add before there exists an document, please create a document using newDocument('NAME')");
    }
    _currentDoc.add(_getIndent()+data);
  }

  void addImport(String path){
    if(_currentDoc == null){
      throw UnsupportedError("You cant addImport before there exists an document, please create a document using newDocument('NAME')");
    }
    _currentDoc.imports.add(path);
  }

  void newline() {
    if(_currentDoc == null){
      throw UnsupportedError("You cant add a newline before there exists an document, please create a document using newDocument('NAME')");
    }
    _currentDoc.add('\n');
  }

  void indent() {
    _tabIndex++;
  }

  void outdent() {
    _tabIndex--;
    if(_tabIndex < 0 ) {
      resetIndent();
    }
  }

  void resetIndent() {
    _tabIndex = 0;
  }

  void addTest(CanOutputToDocument item) {
    item.addToDocument(this);
  }

  String _getIndent(){
    var indent = '';
    for(var i=0; i<_tabIndex; i++){
      indent += '\t';
    }
    return indent;
  }

}