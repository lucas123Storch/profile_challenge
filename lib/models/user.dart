class User {
  int? id;
  String? name;
  String? email;
  String? cpf;
  String? avatar;
  String? phone;
  String? gender;
  // ignore: non_constant_identifier_names
  String? marital_status;

  User({this.id, this.name, this.email, this.cpf, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    avatar = json['avatar'];
    phone = json['phone'];
    gender = json['gender'];
    marital_status = json['marital_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['marital_status'] = this.marital_status;
    return data;
  }
}
