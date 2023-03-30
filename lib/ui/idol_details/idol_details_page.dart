import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:kpop_info/domain/model/idol.dart';
import 'package:kpop_info/ui/components/info_tile.dart';
import 'package:kpop_info/util/list_ext.dart';

class IdolDetailsPage extends StatelessWidget {
  final Idol idol;

  const IdolDetailsPage({
    super.key,
    required this.idol,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: idol.image ?? "",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(idol.nativeNames.join("\n")),
              ),
              const SizedBox(height: 4),
              if (idol.description != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(idol.description!),
                ),
              ...idol.info.entries
                  .mapIndexed((i, e) =>
                      InfoTile(name: e.key, info: e.value, even: i % 2 == 0))
                  .toList(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
