class UserToLogin {
  late String email;
  late String password;
  late String deviceName;

  UserToLogin(
      {required this.email, required this.password, required this.deviceName});

  UserToLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceName = json['device_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_name'] = this.deviceName;
    return data;
  }
}
