class ResponseModel {
  bool? status;
  dynamic message;
  dynamic data;

  ResponseModel(this.status, this.message, this.data);

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(json['status'], json['message'], json['data']);
  }
}
