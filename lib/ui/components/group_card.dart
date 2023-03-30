import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onPressed,
  });

  final String imageUrl;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
