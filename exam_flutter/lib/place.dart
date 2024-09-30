class Place {
  final int? id;
  final String name;
  final String imageUrl;

  Place({this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
