class Idol {
  final String name;
  final String image;

  Idol({
    required this.name,
    required this.image,
  });

  factory Idol.fromMap(Map<String, dynamic> map) {
    return Idol(
      name: map["name"],
      image: map["image"],
    );
  }
}
