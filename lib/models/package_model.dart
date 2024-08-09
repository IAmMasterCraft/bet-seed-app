class PackageModel {
  final String packageId;
  final String title;
  final String amount;
  final int duration;
  final String quantity;
  final String roi;
  final int type;
  final Function()? refreshFxn;

  PackageModel(
    this.packageId,
    this.title,
    this.amount,
    this.duration,
    this.quantity,
    this.roi,
    this.type,
    this.refreshFxn,
  );

  PackageModel.fromJson(Map<dynamic, dynamic> json)
      : packageId = json['packageId'],
        title = json['title'],
        amount = json['amount'],
        duration = json['duration'],
        quantity = json['quantity'],
        roi = json['roi'],
        type = json['type'],
        refreshFxn = json['refreshFxn'];

  Map<String, dynamic> toJson() => {
        'packageId': packageId,
        'title': title,
        'amount': amount,
        'duration': duration,
        'quantity': quantity,
        'roi': roi,
        'type': type,
        'refreshFxn': refreshFxn,
      };
}
