import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/repository/main_repository.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';

const _pageSize = 50;

@injectable
class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final MainRepository repository;

  GroupListBloc(this.repository) : super(GroupListState.initial()) {
    state.pagingController.addPageRequestListener((pageKey) {
      _fetchGroups(pageKey);
    });
  }

  void _fetchGroups(String key) async {
    final groups = await repository.getGroups(
      lastGroup: key,
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
