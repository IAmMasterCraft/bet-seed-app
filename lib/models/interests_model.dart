class InterestModel {
  final String email;
  final String reference;
  final String interest;
  final String amount;
  final String roi;
  final String startDate;
  final String nextDate;
  final String endDate;
  InterestModel(
    this.email,
    this.reference,
    this.interest,
    this.amount,
    this.roi,
    this.startDate,
    this.nextDate,
    this.endDate,
  );

  InterestModel.fromJson(Map json)
      : email = json['email'],
        reference = json['reference'],
        interest = json['interest'],
        amount = json['amount'],
        roi = json['roi'],
        startDate = json['startDate'],
        nextDate = json['nextDate'],
        endDate = json['endDate'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'reference': reference,
        'interest': interest,
        'amount': amount,
        'roi': roi,
        'startDate': startDate,
        'nextDate': nextDate,
        'endDate': endDate,
      };
}
