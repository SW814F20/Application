import 'dart:convert';

import 'JsonElementFactory.dart';

class JsonScreenFactory {

  static dynamic Screen({id = 1, name = 'Awesome Screen', elements, asString = false}){
    var _id = (id != null) ? '"id":$id,' : '';
    var _name = (name != null) ? '"name":"$name",' : '';
    elements ??= [JsonElementFactory.Text(), JsonElementFactory.Button()];

    return _combineAndDecode(_id, _name, elements, asString);
  }

  static dynamic _combineAndDecode(id, name, elements, asString){
    var _combinedElements = '';

    elements.forEach((field) {
      _combinedElements += json.encode(field)+',';
    });

    var ret = '{$id $name "elements": [${_combinedElements.substring(0, _combinedElements.length-1)}]}';

    if(asString){
      return ret;
    }else {
      return json.decode(ret);
    }
  }
}