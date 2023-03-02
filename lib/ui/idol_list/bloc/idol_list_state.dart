part of 'idol_list_bloc.dart';

@immutable
class IdolListState {
  final TextEditingController searchController;
  final PagingController<String, Idol> pagingController;

  const IdolListState({
    required this.searchController,
    required this.pagingController,
  });

  factory IdolListState.initial() {
    return IdolListState(
      searchController: TextEditingController(),
      pagingController: PagingController(firstPageKey: ""),
    );
  }
}
