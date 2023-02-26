import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:kpop_info/domain/model/idol.dart';

class IdolCard extends StatelessWidget {
  final Idol idol;

  const IdolCard({super.key, required this.idol});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: idol.image,
          width: 72,
          height: 72,
        ),
        Text(idol.name),
      ],
    );
  }
}
