import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';

import 'membership_model.dart';
import 'near_by_service_model.dart';

class GetLatestUpdateModel {
  String? type;
  String? serviceName;
  String? subServiceName;
  List<dynamic>? imageUrl;
  NearServiceModel? service;
  String? packageName;
  PackagesModel? package;
  String? membershipName;
  MembershipModel? membership;
  dynamic subServiceId;

  GetLatestUpdateModel(
      {this.type,
        this.serviceName,
        this.subServiceName,
        this.imageUrl,
        this.service,
        this.packageName,
        this.package,
        this.subServiceId,
        this.membershipName,
        this.membership});

  GetLatestUpdateModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    serviceName = json['serviceName'];
    subServiceName = json['subServiceName'];
    imageUrl = json['imageUrl'];
    service =
    json['service'] != null ?  NearServiceModel.fromJson(json['service']) : null;
    packageName = json['packageName'];
    package =
    json['package'] != null ?  PackagesModel.fromJson(json['package']) : null;
    membershipName = json['membershipName'];
    membership = json['membership'] != null
        ?  MembershipModel.fromJson(json['membership'])
        : null;
    subServiceId=json['subserviceName']!=null?json['subserviceName']?.first['id']:null;
  }
}