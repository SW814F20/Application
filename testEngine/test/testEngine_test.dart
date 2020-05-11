import 'package:testEngine/src/UISpec.dart';
import 'package:testEngine/testEngine.dart';
import 'package:test/test.dart';

import 'JsonElementFactory.dart';
import 'JsonScreenFactory.dart';

void main() {
  group('JSON tests', () {
    test('should be able to parse json format', (){
      var _json = JsonScreenFactory.Screen(id: 43, name: 'Login-page', elements: [
        JsonElementFactory.TextInput(),
        JsonElementFactory.TextInput(obscureText: true),
        JsonElementFactory.Button()
      ], asString: true);
      var te = TestEngine();
      var ui = te.parseLayout(_json);
      expect(ui.runtimeType, UISpec);
      expect(ui.name, 'Login-page');
      expect(ui.id, 43);
      expect(ui.elements.length, 3);

      expect(ui.elements[0].type, 'TextInput');

      expect(ui.elements[1].type, 'TextInput');

      expect(ui.elements[2].type, 'Button');
    });
  });
}
