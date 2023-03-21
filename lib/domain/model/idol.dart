import 'package:kpop_info/domain/model/gender.dart';

class Idol {
  final String name;
  final String? image;
  final List<String> nativeNames;
  final Map<String, String> info;
  final String? group;
  final List<String> groups;
  final String? description;
  final String? signature;
  final List<String> facts;
  final Gender gender;

  Idol({
    required this.name,
    required this.image,
    required this.nativeNames,
    required this.info,
    required this.group,
    required this.groups,
    required this.description,
    required this.signature,
    required this.facts,
    required this.gender,
  });

  factory Idol.fromMap(Map<String, dynamic> map) {
    return Idol(
      name: map["name"],
      image: map["image"],
      nativeNames:
          (map["native_name"] as List?)?.map((e) => e as String).toList() ?? [],
      info: (map["info"] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as String)) ??
          {},
      group: map["group"],
      groups: (map["groups"] as List?)?.map((e) => e as String).toList() ?? [],
      description: (map["description"] as String?)
          ?.replaceAll("https://kpopping.com", ""),
      signature: map["signature"],
      facts: (map["facts"] as List?)?.map((e) => e as String).toList() ?? [],
      gender: map["gender"] == "male" ? Gender.male : Gender.female,
    );
  }
}
