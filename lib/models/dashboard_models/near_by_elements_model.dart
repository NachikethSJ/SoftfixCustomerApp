// class NearByShopModel {
//   int id;
//   String branchId;
//   String name;
//   String mobile;
//   double lat;
//   double lng;
//   String description;
//   String gstNo;
//   String tinNo;
//   String panNo;
//   String aadhaar;
//   String address;
//   String pin;
//   String file;
//   String country;
//   String state;
//   String city;
//   String status;
//   dynamic token;
//   dynamic createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   dynamic updatedAt;
//   int isDelete;
//   dynamic review;
//   dynamic comment;
//   dynamic percentage;
//   dynamic otp;
//   dynamic otpTime;
//   String vendorId;
//   String shopId;
//   List<NearByShopModelService> services;
//   List<Package> package;
//   List<Membership> membership;
//   String countryName;
//   String stateName;
//   String cityName;
//   String branchName;
//   List<String> imageUrl;
//
//   NearByShopModel({
//     required this.id,
//     required this.branchId,
//     required this.name,
//     required this.mobile,
//     required this.lat,
//     required this.lng,
//     required this.description,
//     required this.gstNo,
//     required this.tinNo,
//     required this.panNo,
//     required this.aadhaar,
//     required this.address,
//     required this.pin,
//     required this.file,
//     required this.country,
//     required this.state,
//     required this.city,
//     required this.status,
//     required this.token,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDelete,
//     required this.review,
//     required this.comment,
//     required this.percentage,
//     required this.otp,
//     required this.otpTime,
//     required this.vendorId,
//     required this.shopId,
//     required this.services,
//     required this.package,
//     required this.membership,
//     required this.countryName,
//     required this.stateName,
//     required this.cityName,
//     required this.branchName,
//     required this.imageUrl,
//   });
//
// }
//
// class Membership {
//   int id;
//   String shopId;
//   String membershipName;
//   String serviceId;
//   String subServiceId;
//   int userId;
//   DateTime startDate;
//   DateTime endDate;
//   int price;
//   String serviceTypeId;
//   int offer;
//   String details;
//   String termAndcondition;
//   String createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   dynamic updatedAt;
//   dynamic mode;
//   int noOfTimes;
//   int isDelete;
//   String file;
//   int status;
//   List<String> image;
//   ServiceDetailElement service;
//
//   Membership({
//     required this.id,
//     required this.shopId,
//     required this.membershipName,
//     required this.serviceId,
//     required this.subServiceId,
//     required this.userId,
//     required this.startDate,
//     required this.endDate,
//     required this.price,
//     required this.serviceTypeId,
//     required this.offer,
//     required this.details,
//     required this.termAndcondition,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.mode,
//     required this.noOfTimes,
//     required this.isDelete,
//     required this.file,
//     required this.status,
//     required this.image,
//     required this.service,
//   });
//
// }
//
// class ServiceDetailElement {
//   int id;
//   String name;
//   int shopId;
//   String userId;
//   String createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   dynamic updatedAt;
//   int isDelete;
//   dynamic mode;
//   String serviceTypeId;
//   SubService subService;
//
//   ServiceDetailElement({
//     required this.id,
//     required this.name,
//     required this.shopId,
//     required this.userId,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDelete,
//     required this.mode,
//     required this.serviceTypeId,
//     required this.subService,
//   });
//
// }
//
// class SubService {
//   int id;
//   int serviceId;
//   int userId;
//   String type;
//   int price;
//   int timeTaken;
//   String offer;
//   String details;
//   int persontype;
//   String termAndcondition;
//   int file;
//   String createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   dynamic updatedAt;
//   int isDelete;
//   dynamic rating;
//   int status;
//   dynamic comment;
//
//   SubService({
//     required this.id,
//     required this.serviceId,
//     required this.userId,
//     required this.type,
//     required this.price,
//     required this.timeTaken,
//     required this.offer,
//     required this.details,
//     required this.persontype,
//     required this.termAndcondition,
//     required this.file,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDelete,
//     required this.rating,
//     required this.status,
//     required this.comment,
//   });
//
// }
//
// class Package {
//   int id;
//   int userId;
//   String packageName;
//   DateTime startDate;
//   DateTime endDate;
//   int price;
//   String details;
//   String termAndcondition;
//   String createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   dynamic updatedAt;
//   dynamic mode;
//   String shopId;
//   List<ServiceId> serviceId;
//   int discount;
//   String file;
//   int isDelete;
//   int status;
//   List<String> image;
//   List<ServiceDetailElement> serviceDetail;
//
//   Package({
//     required this.id,
//     required this.userId,
//     required this.packageName,
//     required this.startDate,
//     required this.endDate,
//     required this.price,
//     required this.details,
//     required this.termAndcondition,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.mode,
//     required this.shopId,
//     required this.serviceId,
//     required this.discount,
//     required this.file,
//     required this.isDelete,
//     required this.status,
//     required this.image,
//     required this.serviceDetail,
//   });
//
// }
//
// class ServiceId {
//   int id;
//   String subServiceId;
//
//   ServiceId({
//     required this.id,
//     required this.subServiceId,
//   });
//
// }
//
// class NearByShopModelService {
//   int id;
//   String name;
//   int shopId;
//   String userId;
//   String createdBy;
//   String? updatedBy;
//   DateTime createdAt;
//   DateTime? updatedAt;
//   int isDelete;
//   int? mode;
//   String serviceTypeId;
//   List<SubService> subService;
//
//   NearByShopModelService({
//     required this.id,
//     required this.name,
//     required this.shopId,
//     required this.userId,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDelete,
//     required this.mode,
//     required this.serviceTypeId,
//     required this.subService,
//   });
//
// }
