import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:kpop_info/domain/model/idol.dart';

class IdolCard extends StatelessWidget {
  final Idol idol;
  final void Function() onPressed;

  const IdolCard({
    super.key,
    required this.idol,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: CachedNetworkImage(
              imageUrl: idol.image ?? "",
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          Text(idol.name),
        ],
      ),
    );
  }
}
