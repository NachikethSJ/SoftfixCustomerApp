class GetHelpMessageModel {
  int? id;
  String? name;
  String? message;
  int? status;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  int? isDelete;
  int? vendorId;
  int? userId;

  GetHelpMessageModel(
      {this.id,
        this.name,
        this.message,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.vendorId,
        this.userId});

  GetHelpMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    message = json['message'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['IsDelete'];
    vendorId = json['vendorId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['IsDelete'] = this.isDelete;
    data['vendorId'] = this.vendorId;
    data['userId'] = this.userId;
    return data;
  }
}
