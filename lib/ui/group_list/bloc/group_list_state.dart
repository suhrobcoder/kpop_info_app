part of 'group_list_bloc.dart';

@immutable
class GroupListState {
  final TextEditingController searchController;
  final PagingController<String, Group> pagingController;
  final FilterType filterType;

  const GroupListState({
    required this.searchController,
    required this.pagingController,
    required this.filterType,
  });

  factory GroupListState.initial() {
    return GroupListState(
      searchController: TextEditingController(),
      pagingController: PagingController(firstPageKey: ""),
      filterType: FilterType.all,
    );
  }

  GroupListState copyWith({
    TextEditingController? searchController,
    PagingController<String, Group>? pagingController,
    FilterType? filterType,
  }) {
    return GroupListState(
      searchController: this.searchController,
      pagingController: this.pagingController,
      filterType: filterType ?? this.filterType,
    );
  }
}
