class TopGame {
  final String name;
  final String image;
  final String banner;

  TopGame({required this.name, required this.image, required this.banner});

  factory TopGame.fromMap(dynamic map) {
    return TopGame(
      name: map['name'],
      image: map['image'],
      banner: map['banner'],
    );
  }
}
