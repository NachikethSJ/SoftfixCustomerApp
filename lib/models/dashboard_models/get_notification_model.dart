class GetNotificationListModel {
  dynamic id;
  dynamic customerId;
  String? title;
  String? body;
  String? image;
  String? url;
  String? createdAt;
  String? updatedAt;
  dynamic isDelete;
  dynamic isRead;

  GetNotificationListModel(
      {this.id,
        this.customerId,
        this.title,
        this.body,
        this.image,
        this.url,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.isRead});

  GetNotificationListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['isDelete'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isDelete'] = this.isDelete;
    data['isRead'] = this.isRead;
    return data;
  }
}
