enum UserType { PARTICULAR, PROFESSIONAL }

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String password;
  String password2;
  UserType type = UserType.PARTICULAR;
  DateTime createdAt;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.password2,
      this.type = UserType.PARTICULAR,
      this.createdAt});

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phone: $phone, password: $password, password2: $password2, type: $type, createdAt: $createdAt}';
  }
}
