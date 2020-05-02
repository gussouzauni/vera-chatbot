class User {
  String name;
  String email;
  String photo;
  String cpf;
  String cnpj;

  User({this.name, this.email, this.photo, this.cpf, this.cnpj});

  factory User.fromMap(Map data) {
    return User(
        name: data['name'],
        email: data['email'],
        photo: data['photo'],
        cpf: data['cpf'],
        cnpj: data['cnpj']);
  }
}
