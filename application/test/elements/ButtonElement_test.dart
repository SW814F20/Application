import 'package:application/elements/ButtonElement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ButtonElement should return type and name, when calling display', (){
    var el = ButtonElement('Login', 0);

    expect(el.display(), 'Button: Login');
  });

  test('ButtonElement should return type and position, when calling display and name is null', (){
    var el = ButtonElement(null, 0);

    expect(el.display(), 'Button: 0');
  });

  test('ButtonElement should be able to serialize to json', (){
    var el =  ButtonElement('Login', 0);

    expect(el.toJson(), '{"type": "Button", "name": "Login", "position": 0}');
  });
}