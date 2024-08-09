class PayoutModel {
  final String paymentMethod;
  final String fullName;
  final String createdDate;
  final String updatedDate;
  final String amount;
  final String address;
  final String reference;
  final int status;

  PayoutModel(
    this.paymentMethod,
    this.fullName,
    this.createdDate,
    this.updatedDate,
    this.amount,
    this.address,
    this.reference,
    this.status,
  );

  PayoutModel.fromJson(Map<String, dynamic> json)
      : paymentMethod = json['paymentMethod'],
        fullName = json['fullName'],
        createdDate = json['createdDate'],
        updatedDate = json['updatedDate'],
        amount = json['amount'],
        address = json['address'],
        reference = json['reference'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'paymentMethod': paymentMethod,
        'fullName': fullName,
        'createdDate': createdDate,
        'updatedDate': updatedDate,
        'amount': amount,
        'address': address,
        'reference': reference,
        'status': status,
      };
}
