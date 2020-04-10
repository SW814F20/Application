class EditorScreenElement {
  EditorScreenElement({this.type, this.textValue, this.key});

  String type;
  String textValue;
  String key;

  String display() {
    return 'Type: $type, key: $key';
  }
}