import 'package:kpop_info/domain/model/idol.dart';

class Group {
  final String name;
  final String? image;
  final List<String> nativeNames;
  final String? description;
  final Map<String, String> info;
  final String? logo;
  final String? lightstick;
  final List<Idol> members;

  Group({
    required this.name,
    this.image,
    required this.nativeNames,
    this.description,
    this.info = const {},
    this.logo,
    this.lightstick,
    this.members = const [],
  });

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      name: map["name"],
      image: map["image"],
      nativeNames:
          (map["native_name"] as List).map((e) => e as String).toList(),
      description: map["description"],
      info: (map["info"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as String)),
      logo: map["logo"],
      lightstick: map["lightstick"],
      members: (map["members"] as List).map((e) => Idol.fromMap(e)).toList(),
    );
  }
}
