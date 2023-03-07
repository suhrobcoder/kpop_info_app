import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/repository/main_repository.dart';

import '../../../util/filter_type.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';

const _pageSize = 50;

@injectable
class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final MainRepository repository;

  GroupListBloc(this.repository) : super(GroupListState.initial()) {
    on<SearchEvent>((event, emit) {
      state.pagingController.refresh();
    });
    on<OnClearEvent>((event, emit) {
      state.searchController.clear();
      state.pagingController.refresh();
    });
    on<ChangeFilterType>((event, emit) {
      emit(state.copyWith(filterType: event.filterType));
      state.pagingController.refresh();
    });
    state.pagingController.addPageRequestListener((pageKey) {
      if (state.searchController.text.isEmpty) {
        _fetchGroups(pageKey);
      } else {
        _search(state.searchController.text, pageKey);
      }
    });
  }

  void _fetchGroups(String key) async {
    final groups = await repository.getGroups(
      lastGroup: key,
      filterType: state.filterType,
      pageSize: _pageSize,
    );
    if (groups.length < _pageSize) {
      state.pagingController.appendLastPage(groups);
    } else {
      state.pagingController.appendPage(groups, groups.last.name);
    }
  }

  void _search(String query, String key) async {
    final groups = await repository.searchGroups(
      search: query,
      lastGroup: key,
      filterType: state.filterType,
      pageSize: _pageSize,
    );
    if (groups.length < _pageSize) {
      state.pagingController.appendLastPage(groups);
    } else {
      state.pagingController.appendPage(groups, groups.last.name);
    }
  }

  @override
  Future<void> close() {
    state.pagingController.dispose();
    return super.close();
  }
}
