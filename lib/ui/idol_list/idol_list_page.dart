import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kpop_info/di/init_get_it.dart';
import 'package:kpop_info/domain/model/idol.dart';
import 'package:kpop_info/ui/idol_details/idol_details_page.dart';
import 'package:kpop_info/ui/idol_list/bloc/idol_list_bloc.dart';
import 'package:kpop_info/util/filter_type.dart';

class IdolListPage extends StatelessWidget {
  const IdolListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<IdolListBloc>(),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Kpop Xplore"),
        ),
        child: SafeArea(
          child: BlocBuilder<IdolListBloc, IdolListState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CupertinoSearchTextField(
                      controller: state.searchController,
                      placeholder: "Search",
                      onSubmitted: (value) =>
                          context.read<IdolListBloc>().add(SearchEvent(value)),
                      onSuffixTap: () =>
                          context.read<IdolListBloc>().add(OnClearEvent()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSegmentedControl(
                      children: const {
                        FilterType.all: Text("All"),
                        FilterType.male: Text("Male"),
                        FilterType.female: Text("Female"),
                      },
                      groupValue: state.filterType,
                      onValueChanged: (type) => context
                          .read<IdolListBloc>()
                          .add(ChangeFilterType(type)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: PagedListView(
                      pagingController: state.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Idol>(
                        itemBuilder: (context, idol, index) {
                          return CupertinoListTile.notched(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            title: Text(idol.name),
                            leading: CachedNetworkImage(
                              imageUrl: idol.image ?? "",
                            ),
                            onTap: () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => IdolDetailsPage(idol: idol),
                                title: idol.name,
                              ),
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (_) =>
                            const CupertinoActivityIndicator(),
                        newPageProgressIndicatorBuilder: (_) =>
                            const CupertinoActivityIndicator(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
