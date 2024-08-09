class SubscriptionModel {
  final String title;
  final String email;
  final String startDate;
  final String endDate;
  final String amount;
  final int duration;
  final String reference;
  final String roi;

  SubscriptionModel(
    this.title,
    this.email,
    this.startDate,
    this.endDate,
    this.amount,
    this.duration,
    this.reference,
    this.roi,
  );

  SubscriptionModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        email = json['email'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        amount = json['amount'],
        duration = json['duration'],
        reference = json['reference'],
        roi = json['roi'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'email': email,
        'startDate': startDate,
        'endDate': endDate,
        'amount': amount,
        'duration': duration,
        'reference': reference,
        'roi': roi,
      };
}
