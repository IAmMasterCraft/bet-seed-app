class InvestmentModel {
  final String title;
  final String email;
  final String startDate;
  final String endDate;
  final String amount;
  final int duration;
  final String roi;
  final String? reference;
  final String? hash;
  final String? payMethod;
  final int status;
  final int type;

  InvestmentModel(
    this.title,
    this.email,
    this.startDate,
    this.endDate,
    this.amount,
    this.duration,
    this.roi,
    this.reference,
    this.hash,
    this.payMethod,
    this.status,
    this.type,
  );

  InvestmentModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        email = json['email'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        amount = json['amount'],
        duration = json['duration'],
        roi = json['roi'],
        reference = json['reference'],
        status = json['status'],
        type = json['type'],
        payMethod = json['payMethod'],
        hash = json['hash'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'email': email,
        'startDate': startDate,
        'endDate': endDate,
        'amount': amount,
        'duration': duration,
        'roi': roi,
        'reference': reference,
        'status': status,
        'type': type,
        'payMethod': payMethod,
        'hash': hash,
      };
}
