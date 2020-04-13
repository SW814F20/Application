class EditorScreenElement {
  EditorScreenElement({this.widgetType, this.position, this.key});

  int position;
  String widgetType;
  String key;

  String display() {
    return 'Type: $widgetType, key: $key';
  }
}