class UserModel {
  final String userName;
  final String age;
  final String phone;
  final String password;
  final String role;
  final String id;
  final String idUser;

  UserModel(
      {required this.userName,
      required this.phone,
      required this.password,
      required this.age,
      required this.role,
      required this.id,
      required this.idUser});
}
