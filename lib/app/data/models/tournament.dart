class Tournament {
  String id;
  String name;
  String description;
  String image;
  String platform;
  String rules;
  double amount;
  String date;
  String status = 'open';
  String? winner;
  String? time;
  List<String> players = [];
  List<String> rounds = [];

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.platform,
    required this.rules,
    required this.amount,
    required this.date,
    this.status = 'open',
    this.winner,
    this.time,
    required this.players,
    required this.rounds,
  });

  factory Tournament.fromMap(dynamic map) {
    return Tournament(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      image: map['image'] ?? "",
      platform: map['platform'] ?? "",
      rules: map['rules'] ?? "",
      amount: double.parse(map['amount'].toString()),
      date: map['date'] ?? "",
      status: map['status'] ?? 'open',
      winner: map['winner'] ?? "",
      time: map['time'] ?? "",
      players: map['players'] == null
          ? []
          : List<String>.from(map['players'] ?? <String>[]),
      rounds: map['rounds'] == null
          ? []
          : List<String>.from(map['rounds'] ?? <String>[]),
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
      'date': date,
      'status': status,
      'winner': winner,
      'time': time,
      'players': players,
      'rounds': rounds,
    };
  }
}


// open
// closed
// started
// under review
