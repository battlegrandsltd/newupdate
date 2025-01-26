class Round {
  String id;
  String name;
  List<String> players;
  List<String> games;
  String tournamentId;
  String status = 'open';
  List<String> winners;
  String? time;
  String date;

  Round({
    required this.id,
    required this.name,
    required this.players,
    required this.games,
    required this.tournamentId,
    this.status = 'open',
    required this.winners,
    this.time,
    required this.date,
  });

  factory Round.fromMap(dynamic map) {
    return Round(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      players: map['players'] == null
          ? []
          : List<String>.from(map['players'] ?? <String>[]),
      games: map['games'] == null
          ? []
          : List<String>.from(map['games'] ?? <String>[]),
      tournamentId: map['tournamentId'] ?? "",
      status: map['status'] ?? 'open',
      winners: map['winners'] == null
          ? []
          : List<String>.from(map['winners'] ?? <String>[]),
      time: map['time'] ?? "",
      date: map['date'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'players': players,
      'games': games,
      'tournamentId': tournamentId,
      'status': status,
      'winners': winners,
      'time': time,
      'date': date,
    };
  }
}
