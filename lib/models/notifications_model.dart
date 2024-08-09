class NotificationsModel {
  final String notificationId;
  final String notificationTitle;
  final String notificationBody;
  final Function()? refreshFxn;

  NotificationsModel(
    this.notificationId,
    this.notificationTitle,
    this.notificationBody,
    this.refreshFxn,
  );

  NotificationsModel.fromJson(Map<String, dynamic> json)
      : notificationId = json['notificationId'],
        notificationTitle = json['notificationTitle'],
        notificationBody = json['notificationBody'],
        refreshFxn = json['refreshFxn'];

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'refreshFxn': refreshFxn,
      };
}
