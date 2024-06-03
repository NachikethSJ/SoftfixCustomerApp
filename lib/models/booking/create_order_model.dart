class CreateOrderModel {
  dynamic cartDetails;
  String? cfOrderId;
  String? createdAt;
  CustomerDetails? customerDetails;
  String? entity;
  dynamic orderAmount;
  String? orderCurrency;
  String? orderExpiryTime;
  String? orderId;
  OrderMeta? orderMeta;
  dynamic orderNote;
  dynamic orderSplits;
  String? orderStatus;
  dynamic orderTags;
  String? paymentSessionId;
  dynamic terminalData;

  CreateOrderModel(
      {this.cartDetails,
        this.cfOrderId,
        this.createdAt,
        this.customerDetails,
        this.entity,
        this.orderAmount,
        this.orderCurrency,
        this.orderExpiryTime,
        this.orderId,
        this.orderMeta,
        this.orderNote,
        this.orderSplits,
        this.orderStatus,
        this.orderTags,
        this.paymentSessionId,
        this.terminalData});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    cartDetails = json['cart_details'];
    cfOrderId = json['cf_order_id'];
    createdAt = json['created_at'];
    customerDetails = json['customer_details'] != null
        ? CustomerDetails.fromJson(json['customer_details'])
        : null;
    entity = json['entity'];
    orderAmount = json['order_amount'];
    orderCurrency = json['order_currency'];
    orderExpiryTime = json['order_expiry_time'];
    orderId = json['order_id'];
    orderMeta = json['order_meta'] != null
        ? OrderMeta.fromJson(json['order_meta'])
        : null;
    orderNote = json['order_note'];
    orderSplits=json['order_splits'];

    orderStatus = json['order_status'];
    orderTags = json['order_tags'];
    paymentSessionId = json['payment_session_id'];
    terminalData = json['terminal_data'];
  }

  
}

class CustomerDetails {
  String? customerId;
  dynamic customerName;
  dynamic customerEmail;
  String? customerPhone;
  dynamic customerUid;

  CustomerDetails(
      {this.customerId,
        this.customerName,
        this.customerEmail,
        this.customerPhone,
        this.customerUid});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerUid = json['customer_uid'];
  }

}

class OrderMeta {
  String? returnUrl;
  dynamic notifyUrl;
  String? paymentMethods;

  OrderMeta({this.returnUrl, this.notifyUrl, this.paymentMethods});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    returnUrl = json['return_url'];
    notifyUrl = json['notify_url'];
    paymentMethods = json['payment_methods'];
  }

}
