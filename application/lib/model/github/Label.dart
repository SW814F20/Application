class Label {
  Label.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    url = json['url'];
    name = json['name'];
    color = json['color'];
    defaultValue = json['default'];
    description = json['description'];
  }

  int id;
  String nodeId;
  String url;
  String name;
  String color;
  String defaultValue;
  String description;
}
