import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/repository/main_repository.dart';
import 'package:kpop_info/ui/components/idol_card.dart';
import 'package:kpop_info/ui/components/info_tile.dart';
import 'package:kpop_info/ui/group_discography/group_discography_page.dart';
import 'package:kpop_info/ui/idol_details/idol_details_page.dart';
import 'package:kpop_info/util/list_ext.dart';

class GroupDetailsPage extends StatelessWidget {
  final Group group;

  const GroupDetailsPage({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: const Icon(CupertinoIcons.double_music_note),
          onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => GroupDiscographyPage(group: group),
            title: "Discography",
          )),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: group.image ?? "",
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(group.nativeNames.join("\n")),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: group.members
                      .map((idol) => IdolCard(
                            idol: idol,
                            onPressed: () {
                              getIt<MainRepository>()
                                  .getIdolByName(
                                      name: idol.name, group: group.name)
                                  .then((value) => Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (_) =>
                                              IdolDetailsPage(idol: value),
                                          title: value.name,
                                        ),
                                      ));
                            },
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 4),
              if (group.description != null)
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(group.description!)),
              ...group.info.entries
                  .mapIndexed((i, e) =>
                      InfoTile(name: e.key, info: e.value, even: i % 2 == 0))
                  .toList(),
              Row(
                children: [
                  const SizedBox(width: 16),
                  if (group.logo != null)
                    GestureDetector(
                      onTap: () => showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: CachedNetworkImage(
                              imageUrl: group.logo!,
                            ),
                          );
                        },
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: group.logo!,
                            width: 96,
                            height: 96,
                          ),
                          const Text("Logo"),
                        ],
                      ),
                    ),
                  if (group.lightstick != null)
                    GestureDetector(
                      onTap: () => showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: CachedNetworkImage(
                              imageUrl: group.lightstick!,
                            ),
                          );
                        },
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: group.lightstick!,
                            width: 96,
                            height: 96,
                          ),
                          const Text("Lightstick"),
                        ],
                      ),
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
