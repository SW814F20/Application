import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/CanOutputToDocument.dart';
import 'package:testEngine/src/CodeGenerators/OutputPackage.dart';

class mockCanOutputToDocument extends CanOutputToDocument{
  @override
  void addToDocument(OutputPackage doc) {
    doc.add('Hello world!');
  }

}

void main(){
  OutputPackage package;
  setUp((){
    package = OutputPackage(name: 'TestPackage');
  });

  group('Output Package basics', () {
    test('should throw error if trying to add with out a document', (){
      expect(() => package.add('hello'), throwsA(
          predicate((e) =>
          e is UnsupportedError &&
              e.message == "You cant add before there exists an document, please create a document using newDocument('NAME')"
          )
      ));
    });

    test('should throw error if trying to addImport with out a document', (){
      expect(() => package.addImport('hello'), throwsA(
          predicate((e) =>
          e is UnsupportedError &&
              e.message == "You cant addImport before there exists an document, please create a document using newDocument('NAME')"
          )
      ));
    });

    test('Should be able to return all files as list', () {
      package.newDocument('new-document');
      package.add('sad');
      package.newDocument('another-document');
      package.add('glad');

      var files =  package.files();

      expect(files.length, 2);
      expect(files[0].content, 'sad');
      expect(files[0].name, 'new-document');
      expect(files[1].content, 'glad');
      expect(files[1].name, 'another-document');
    });

    test('Should be able to create a new document', () {
      package.newDocument('new-document');
      var doc = package.getDocument('new-document');
      expect(doc.name, 'new-document');
    });

    test('should be able to switch document', () {
      package.newDocument('new-document');
      package.newDocument('another-document');
      package.add('hello');
      package.switchDocument('new-document');
      package.add('world');
      var doc = package.getDocument('new-document');
      var anotherDoc = package.getDocument('another-document');

      expect(anotherDoc.content, 'hello');
      expect(doc.content, 'world');
    });

    test('Should throw error if switching to unknown document', (){
      expect(() => package.switchDocument('not-found'), throwsA(
          predicate((e) =>
          e is ArgumentError &&
              e.message == "No document found named 'not-found'!"
          )
      ));
    });

    test('should allow for registering imports', (){
      package.newDocument('new-document');
      package.add('hello');
      package.addImport('path/to/import/file');
      var doc = package.getDocument('new-document');
      expect(doc.content, 'import \'path/to/import/file\';\n\n\nhello');
    });

    test('when switchting document tabIndex should get reset', () {
      package.newDocument('doc1');
      package.newDocument('doc2');
      package.indent();
      package.add('hello');
      package.switchDocument('doc1');
      package.add('world');
      var doc = package.getDocument('doc1');
      var doc2 = package.getDocument('doc2');
      expect(doc.content, 'world');
      expect(doc2.content, '\thello');
    });

    test('when creating a new document tabIndex should get reset', () {
      package.newDocument('doc1');
      package.indent();
      package.add('hello');
      package.newDocument('doc2');
      package.add('world');
      var doc = package.getDocument('doc1');
      var doc2 = package.getDocument('doc2');
      expect(doc2.content, 'world');
      expect(doc.content, '\thello');
    });

    test('Should be able to add text and retrieve it from document', (){
      package.newDocument('new-document');
      package.add('Hello world!');
      var doc = package.getDocument('new-document');
      expect(doc.content, 'Hello world!');
    });

    test('Should be able to add multiple times and retrieve it all', () {
      package.newDocument('new-document');
      package.add('Hello');
      package.add('world');
      var doc = package.getDocument('new-document');
      expect(doc.content, 'Helloworld');
    });

    test('Should be able to add a CanOutputToDument object',() {
      package.newDocument('new-document');
      var mock = mockCanOutputToDocument();
      package.addTest(mock);
      var doc = package.getDocument('new-document');
      expect(doc.content, 'Hello world!');
    });

    test('Should be able to add method name for test invoketion', (){
      package.newDocument('TestWidget');
      package.addRunner('TestWidget', 'runTestWidgetTests');
      var runners = package.runners.values.toList();

      expect(runners.length, 1);
      expect(runners[0], 'runTestWidgetTests');
    });

    test('Should be able to add multiple method name for test invoketion', (){
      package.newDocument('TestWidget');
      package.addRunner('TestWidget', 'runTestWidgetTests');
      package.addRunner('AnotherTestWidget', 'runAnotherTestWidgetTests');
      var runners = package.runners.values.toList();

      expect(runners.length, 2);
      expect(runners[0], 'runTestWidgetTests');
      expect(runners[1], 'runAnotherTestWidgetTests');
    });

    test('adding a test runner that is already known should throw an error', (){
      package.newDocument('TestWidget');
      package.addRunner('TestWidget', 'runTestWidgetTests');
      expect(() => package.addRunner('TestWidget', 'runTestWidgetTests'),
        throwsA(
            predicate((e) =>
            e is ArgumentError &&
                e.message == 'A runner is already registered for the file \'TestWidget\'!'
            )
        ));
    });

    test('Should be able to add helper methods', (){
      package.addHelperSignature('Widget getTestWidget();');

      var helpers = package.helpers.toList();
      expect(helpers.length, 1);
      expect(helpers[0], 'Widget getTestWidget();');
    });

    test('Should automaticly add a semicolon if signature is not ending on it', (){
      package.addHelperSignature('Widget getTestWidget()');

      var helpers = package.helpers.toList();
      expect(helpers.length, 1);
      expect(helpers[0], 'Widget getTestWidget();');
    });

    test('Should be able to add multiple helper signatures', (){
      package.addHelperSignature('Widget getTestWidget()');
      package.addHelperSignature('Widget getAnotherTestWidget();');

      var helpers = package.helpers.toList();
      expect(helpers.length, 2);
      expect(helpers[0], 'Widget getTestWidget();');
      expect(helpers[1], 'Widget getAnotherTestWidget();');
    });

    test('If same helper signature is added multiple times should one include one', (){
      package.addHelperSignature('Widget getTestWidget()');
      package.addHelperSignature('Widget getTestWidget()');
      package.addHelperSignature('Widget getTestWidget()');

      var helpers = package.helpers.toList();
      expect(helpers.length, 1);
      expect(helpers[0], 'Widget getTestWidget();');
    });
  });

  group('Output document formatting', () {
    test('Should be able to increase the tab index', (){
      package.newDocument('new-document');
      package.add('hello');
      package.indent();
      package.add('world');
      var doc = package.getDocument('new-document');
      expect(doc.content,'hello\tworld');
    });

    test('Should be able to decrease the tab index', (){
      package.newDocument('new-document');
      package.add('hello');
      package.indent();
      package.add('world');
      package.outdent();
      package.add('!');
      var doc = package.getDocument('new-document');
      expect(doc.content,'hello\tworld!');
    });

    test('Should not be able to decrease the tab index below zero', () {
      package.newDocument('new-document');
      package.indent();
      package.outdent();
      package.outdent();
      package.add('hello');
      package.indent();
      package.add('world');
      var doc = package.getDocument('new-document');
      expect(doc.content,'hello\tworld');
    });

    test('Should be able to reset tab index to zero', () {
      package.newDocument('new-document');
      package.add('hello');
      package.indent();
      package.indent();
      package.indent();
      package.add('world');
      package.resetIndent();
      package.add('!');
      var doc = package.getDocument('new-document');
      expect(doc.content, 'hello\t\t\tworld!');
    });

    test('Should be able to add a newline', () {
      package.newDocument('new-document');
      package.add('hello');
      package.newline();
      package.add('world');
      var doc = package.getDocument('new-document');
      expect(doc.content, 'hello\nworld');
    });

    test('newlines should not have indentations', (){
      package.newDocument('new-document');
      package.add('hello');
      package.indent();
      package.newline();
      package.add('world');
      var doc = package.getDocument('new-document');
      expect(doc.content, 'hello\n\tworld');
    });

    test('Should throw error if trying to add newline before a document is created', (){
      expect(() => package.newline(), throwsA(
          predicate((e) =>
          e is UnsupportedError &&
              e.message == "You cant add a newline before there exists an document, please create a document using newDocument('NAME')"
          )
      ));
    });
  });
}