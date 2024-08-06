class UserModel {
  final String id;
  final String firstName;
  final String surname;
  final String email;

  UserModel(
      {required this.firstName,
      required this.surname,
      required this.id,
      required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      surname: map['surname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'surname': surname
    };
  }
}
