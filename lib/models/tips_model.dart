class TipsModel {
  final String sportId;
  final String sportType;
  final String league;
  final String teamOne;
  final String teamTwo;
  final String sportDate;
  final String sportTime;
  final String tips;
  final String odds;
  final int status;
  final String probability;
  final int freePaid;
  final Function()? wonLostFxn;
  final Function()? deleteFxn;
  final Function()? refreshFxn;

  TipsModel(
    this.sportId,
    this.sportType,
    this.league,
    this.teamOne,
    this.teamTwo,
    this.sportDate,
    this.sportTime,
    this.tips,
    this.odds,
    this.status,
    this.probability,
    this.freePaid,
    this.wonLostFxn,
    this.deleteFxn,
    this.refreshFxn,
  );

  TipsModel.fromJson(Map<String, dynamic> json)
      : sportId = json['sportId'],
        sportType = json['sportType'],
        league = json['league'],
        teamOne = json['teamOne'],
        teamTwo = json['teamTwo'],
        sportDate = json['sportDate'],
        sportTime = json['sportTime'],
        tips = json['tips'],
        odds = json['odds'],
        status = json['status'],
        probability = json['probability'],
        freePaid = json['freePaid'],
        wonLostFxn = json['wonLostFxn'],
        deleteFxn = json['deleteFxn'],
        refreshFxn = json['refreshFxn'];

  Map<String, dynamic> toJson() => {
        'sportId': sportId,
        'sportType': sportType,
        'league': league,
        'teamOne': teamOne,
        'teamTwo': teamTwo,
        'sportDate': sportDate,
        'sportTime': sportTime,
        'tips': tips,
        'odds': odds,
        'status': status,
        'probability': probability,
        'freePaid': freePaid,
        'wonLostFxn': wonLostFxn,
        'deleteFxn': deleteFxn,
        'refreshFxn': refreshFxn,
      };
}
