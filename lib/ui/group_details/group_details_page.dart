import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/ui/components/idol_card.dart';
import 'package:kpop_info/ui/components/info_tile.dart';

class GroupDetailsPage extends StatelessWidget {
  final Group group;

  const GroupDetailsPage({
    super.key,
    required this.group,
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
              CachedNetworkImage(imageUrl: group.image ?? ""),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    group.members.map((idol) => IdolCard(idol: idol)).toList(),
              ),
              const SizedBox(height: 4),
              if (group.description != null)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(group.description!)),
              ...group.info.entries
                  .map((e) => InfoTile(name: e.key, info: e.value))
                  .toList(),
              Row(
                children: [
                  const SizedBox(width: 16),
                  if (group.logo != null)
                    Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: group.logo!,
                          width: 96,
                          height: 96,
                        ),
                        const Text("Logo"),
                      ],
                    ),
                  if (group.lightstick != null)
                    Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: group.lightstick!,
                          width: 96,
                          height: 96,
                        ),
                        const Text("Lightstick"),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
