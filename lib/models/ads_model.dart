class AdsModel {
  final String adsId;
  final String adsTitle;
  final String adsImage;
  final String adsDescription;
  final String adsLink;
  final int adsType;
  final Function()? refreshFxn;
  final Function()? deleteFxn;

  AdsModel(
    this.adsId,
    this.adsTitle,
    this.adsImage,
    this.adsDescription,
    this.adsLink,
    this.adsType,
    this.refreshFxn,
    this.deleteFxn,
  );

  AdsModel.fromJson(Map<String, dynamic> json)
      : adsId = json['adsId'],
        adsTitle = json['adsTitle'],
        adsImage = json['adsImage'],
        adsDescription = json['adsDescription'],
        adsLink = json['adsLink'],
        adsType = json['adsType'],
        refreshFxn = json['refreshFxn'],
        deleteFxn = json['deleteFxn'];

  Map<String, dynamic> toJson() => {
        'adsId': adsId,
        'adsTitle': adsTitle,
        'adsImage': adsImage,
        'adsDescription': adsDescription,
        'adsLink': adsLink,
        'adsType': adsType,
        'refreshFxn': refreshFxn,
        'deleteFxn': deleteFxn,
      };
}
