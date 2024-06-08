class SlotBySubServicesModel {
  dynamic id;
  String? employName;
  String? employId;
  String? userId;
  String? mobile;
  String? shopId;
  String? serviceTypeId;
  dynamic status;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic isDelete;
  dynamic mode;
  dynamic gender;
  String? file;
  dynamic approvalByAdmin;
  List<dynamic>? image;
  List<Slots>? slots;
  dynamic shopName;

  SlotBySubServicesModel(
      {this.id,
        this.employName,
        this.employId,
        this.userId,
        this.mobile,
        this.shopId,
        this.serviceTypeId,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.mode,
        this.gender,
        this.file,
        this.approvalByAdmin,
        this.image,
        this.slots,
        this.shopName});

  SlotBySubServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employName = json['employName'];
    employId = json['employId'];
    userId = json['userId'];
    mobile = json['mobile'];
    shopId = json['shopId'];
    serviceTypeId = json['serviceTypeId'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['IsDelete'];
    mode = json['mode'];
    gender = json['gender'];
    file = json['file'];
    approvalByAdmin = json['approvalByAdmin'];
    image = json['image'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
    shopName = json['shopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employName'] = this.employName;
    data['employId'] = this.employId;
    data['userId'] = this.userId;
    data['mobile'] = this.mobile;
    data['shopId'] = this.shopId;
    data['serviceTypeId'] = this.serviceTypeId;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['IsDelete'] = this.isDelete;
    data['mode'] = this.mode;
    data['gender'] = this.gender;
    data['file'] = this.file;
    data['approvalByAdmin'] = this.approvalByAdmin;
    data['shopName'] = this.shopName;
    data['image'] = this.image;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  String? start;
  String? end;
  bool? isChecked;

  Slots({this.start, this.end,this.isChecked});

  Slots.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    isChecked=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
