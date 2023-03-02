import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/ui/group_list/group_list_page.dart';
import 'package:kpop_info/ui/home/bloc/home_bloc.dart';
import 'package:kpop_info/ui/idol_list/idol_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _tabs = [
    GroupListPage(),
    IdolListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.group_rounded),
                  label: "Groups",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: "Idols",
                ),
              ],
              currentIndex: state.index,
              onTap: (index) =>
                  context.read<HomeBloc>().add(TabClickEvent(index)),
            ),
            tabBuilder: (context, index) {
              return _tabs[index];
            },
          );
        },
      ),
    );
  }
}
