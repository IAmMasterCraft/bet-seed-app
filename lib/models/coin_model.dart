class CoinHistorynModel {
  final int quantity;
  final String email;
  final String title;
  final String amount;
  final String startDate;
  final String reference;

  CoinHistorynModel(
    this.quantity,
    this.email,
    this.title,
    this.amount,
    this.startDate,
    this.reference,
  );

  CoinHistorynModel.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        title = json['title'],
        email = json['email'],
        amount = json['amount'],
        startDate = json['startDate'],
        reference = json['reference'];

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'title': title,
        'email': email,
        'amount': amount,
        'startDate': startDate,
        'reference': reference,
      };
}
