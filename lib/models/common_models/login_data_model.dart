class LoginDataModel {
  int? id;
  dynamic name;
  String? mobile;
  String? otp;
  String? otpTime;
  String? token;
  int? status;
  String? createdAt;
  dynamic updatedAt;
  int? isDelete;

  LoginDataModel(
      {this.id,
      this.name,
      this.mobile,
      this.otp,
      this.otpTime,
      this.token,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isDelete});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    otp = json['otp'];
    otpTime = json['otpTime'];
    token = json['token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['otp'] = otp;
    data['otpTime'] = otpTime;
    data['token'] = token;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['isDelete'] = isDelete;
    return data;
  }
}
