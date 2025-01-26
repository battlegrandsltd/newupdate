class Medal {
  final String id;
  final String name;
  final String icon;
  final String description;
  final int xp;

  Medal({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.xp,
  });

  factory Medal.fromMap(dynamic map) {
    return Medal(
      id: map['id'],
      name: map['name'],
      icon: map['imageUrl'],
      description: map['description'],
      xp: map['xp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': icon,
      'description': description,
      'xp': xp,
    };
  }
}
