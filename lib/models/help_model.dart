class SupportModel {
  int? fieldCount;
  int? affectedRows;
  int? insertId;
  int? serverStatus;
  int? warningCount;
  String? message;
  bool? protocol41;
  int? changedRows;

  SupportModel(
      {this.fieldCount,
        this.affectedRows,
        this.insertId,
        this.serverStatus,
        this.warningCount,
        this.message,
        this.protocol41,
        this.changedRows});

  SupportModel.fromJson(Map<String, dynamic> json) {
    fieldCount = json['fieldCount'];
    affectedRows = json['affectedRows'];
    insertId = json['insertId'];
    serverStatus = json['serverStatus'];
    warningCount = json['warningCount'];
    message = json['message'];
    protocol41 = json['protocol41'];
    changedRows = json['changedRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldCount'] = this.fieldCount;
    data['affectedRows'] = this.affectedRows;
    data['insertId'] = this.insertId;
    data['serverStatus'] = this.serverStatus;
    data['warningCount'] = this.warningCount;
    data['message'] = this.message;
    data['protocol41'] = this.protocol41;
    data['changedRows'] = this.changedRows;
    return data;
  }
}
