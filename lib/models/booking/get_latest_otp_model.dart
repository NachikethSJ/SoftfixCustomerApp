class GetLatestOTPModel {
  String? otp;

  GetLatestOTPModel({this.otp});

  GetLatestOTPModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    return data;
  }
}
