class UserToCreateOrUpdate {
  late String name;
  late int? id;
  late String email;
  late String cpf;
  late String? avatar;
  late String phone;
  late String gender;
  late String maritalStatus;
  late String? password;
  late String? passwordConfirmation;
  late String? device_name;

  UserToCreateOrUpdate({
    required this.name,
    required this.id,
    required this.email,
    required this.cpf,
    this.avatar,
    required this.phone,
    required this.gender,
    required this.maritalStatus,
    this.password,
    this.passwordConfirmation,
    this.device_name,
  });

  UserToCreateOrUpdate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    cpf = json['cpf'];
    avatar = json['avatar'];
    phone = json['phone'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    device_name = json['device_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['id'] = this.id;
    data['cpf'] = this.cpf;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['device_name'] = this.device_name;
    return data;
  }
}
