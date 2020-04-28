class User {
  String name;
  String email;
  String photo;

  User({this.name, this.email, this.photo});

  factory User.fromMap(Map data) {
    return User(
      name: data['name'],
      email: data['email'],
      photo: data['photo'],
    );
  }
}
