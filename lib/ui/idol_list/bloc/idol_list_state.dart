part of 'idol_list_bloc.dart';

@immutable
class IdolListState {
  final TextEditingController searchController;
  final PagingController<String, Idol> pagingController;
  final FilterType filterType;

  const IdolListState({
    required this.searchController,
    required this.pagingController,
    required this.filterType,
  });

  factory IdolListState.initial() {
    return IdolListState(
      searchController: TextEditingController(),
      pagingController: PagingController(firstPageKey: ""),
      filterType: FilterType.all,
    );
  }

  IdolListState copyWith({
    FilterType? filterType,
  }) {
    return IdolListState(
      searchController: searchController,
      pagingController: pagingController,
      filterType: filterType ?? this.filterType,
    );
  }
}
