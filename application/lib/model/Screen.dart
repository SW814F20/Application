class Screen {
  Screen.fromJson(Map<String, dynamic> json)
      : screenName = json['screenName'],
        screenContent = json['screenContent'],
        id = json['id'];

  String screenName;
  String screenContent;
  int id;
}
