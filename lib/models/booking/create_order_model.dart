class CreateOrderModel {
  String? cfOrderId;
  String? createdAt;
  CustomerDetails? customerDetails;
  String? entity;
  int? orderAmount;
  String? orderCurrency;
  String? orderExpiryTime;
  String? orderId;
  OrderMeta? orderMeta;
  String? orderStatus;
  String? paymentSessionId;

  CreateOrderModel(
      {this.cfOrderId,
        this.createdAt,
        this.customerDetails,
        this.entity,
        this.orderAmount,
        this.orderCurrency,
        this.orderExpiryTime,
        this.orderId,
        this.orderMeta,
        this.orderStatus,
        this.paymentSessionId});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    cfOrderId = json['cf_order_id'];
    createdAt = json['created_at'];
    customerDetails = json['customer_details'] != null
        ? new CustomerDetails.fromJson(json['customer_details'])
        : null;
    entity = json['entity'];
    orderAmount = json['order_amount'];
    orderCurrency = json['order_currency'];
    orderExpiryTime = json['order_expiry_time'];
    orderId = json['order_id'];
    orderMeta = json['order_meta'] != null
        ? new OrderMeta.fromJson(json['order_meta'])
        : null;
    orderStatus = json['order_status'];
    paymentSessionId = json['payment_session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cf_order_id'] = this.cfOrderId;
    data['created_at'] = this.createdAt;
    if (this.customerDetails != null) {
      data['customer_details'] = this.customerDetails!.toJson();
    }
    data['entity'] = this.entity;
    data['order_amount'] = this.orderAmount;
    data['order_currency'] = this.orderCurrency;
    data['order_expiry_time'] = this.orderExpiryTime;
    data['order_id'] = this.orderId;
    if (this.orderMeta != null) {
      data['order_meta'] = this.orderMeta!.toJson();
    }
    data['order_status'] = this.orderStatus;
    data['payment_session_id'] = this.paymentSessionId;
    return data;
  }
}

class CustomerDetails {
  String? customerId;
  String? customerName;
  String? customerEmail;
  String? customerPhone;

  CustomerDetails(
      {this.customerId,
        this.customerName,
        this.customerEmail,
        this.customerPhone});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    return data;
  }
}

class OrderMeta {
  String? returnUrl;

  String? paymentMethods;

  OrderMeta({this.returnUrl,  this.paymentMethods});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    returnUrl = json['return_url'];

    paymentMethods = json['payment_methods'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_url'] = this.returnUrl;

    data['payment_methods'] = this.paymentMethods;
    return data;
  }
}
