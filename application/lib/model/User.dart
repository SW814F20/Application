class User {
  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        username = json['username'],
        token = json['token'];

  final String username;
  final String firstName;
  final String lastName;
  //final String email;
  final String token;

  bool getLoggedIn() {
    return this.token != null;
  }
}
