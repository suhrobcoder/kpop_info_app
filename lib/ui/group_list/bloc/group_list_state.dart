part of 'group_list_bloc.dart';

@immutable
class GroupListState {
  final TextEditingController searchController;
  final PagingController<String, Group> pagingController;

  const GroupListState({
    required this.searchController,
    required this.pagingController,
  });

  factory GroupListState.initial() {
    return GroupListState(
      searchController: TextEditingController(),
      pagingController: PagingController(firstPageKey: ""),
    );
  }
}
