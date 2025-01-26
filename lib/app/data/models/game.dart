class Game {
  String id;
  String name;
  String description;
  String image;
  String platform;
  String rules;
  double amount;
  String? creator;
  String date;
  String player_1;
  String player_2;
  String status = 'open';
  String? winner;
  String? time;
  String? link_1;
  String? link_2;
  String? result_1;
  String? result_2;
  String? tournamentId;
  String? roundId;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.platform,
    required this.rules,
    required this.amount,
    required this.creator,
    required this.date,
    required this.player_1,
    required this.player_2,
    this.status = 'open',
    this.winner,
    this.time,
    this.link_1,
    this.link_2,
    this.result_1,
    this.result_2,
    this.tournamentId,
    this.roundId,
  });

  factory Game.fromMap(dynamic map) {
    return Game(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      image: map['image'] ?? "",
      platform: map['platform'] ?? "",
      rules: map['rules'] ?? "",
      amount: double.parse(map['amount'].toString()),
      creator: map['creator'] ?? "",
      date: map['date'] ?? "",
      player_1: map['player_1'] ?? "",
      player_2: map['player_2'] ?? "",
      status: map['status'] ?? 'open',
      winner: map['winner'] ?? "",
      time: map['time'] ?? "",
      link_1: map['link_1'] ?? "",
      link_2: map['link_2'] ?? "",
      result_1: map['result_1'] ?? "",
      result_2: map['result_2'] ?? "",
      tournamentId: map['tournamentId'] ?? "",
      roundId: map['roundId'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'platform': platform,
      'rules': rules,
      'amount': amount.toString(),
      'creator': creator,
      'date': date,
      'player_1': player_1,
      'player_2': player_2,
      'status': status,
      'winner': winner,
      'time': time,
      'link_1': link_1,
      'link_2': link_2,
      'result_1': result_1,
      'result_2': result_2,
      'tournamentId': tournamentId,
      'roundId': roundId,
    };
  }
}


// open
// closed
// started
// under review
