import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/domain/model/idol.dart';
import 'package:kpop_info/domain/repository/main_repository.dart';
import 'package:kpop_info/util/filter_type.dart';

part 'idol_list_event.dart';
part 'idol_list_state.dart';

const _pageSize = 50;

@injectable
class IdolListBloc extends Bloc<IdolListEvent, IdolListState> {
  final MainRepository repository;

  IdolListBloc(this.repository) : super(IdolListState.initial()) {
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
        _fetchIdols(pageKey);
      } else {
        _search(state.searchController.text, pageKey);
      }
    });
  }

  void _fetchIdols(String key) async {
    final idols = await repository.getIdols(
      lastIdol: key,
      filterType: state.filterType,
      pageSize: _pageSize,
    );
    if (idols.length < _pageSize) {
      state.pagingController.appendLastPage(idols);
    } else {
      state.pagingController.appendPage(idols, idols.last.name);
    }
  }

  void _search(String query, String key) async {
    final idols = await repository.searchIdols(
      search: query,
      lastIdol: key,
      filterType: state.filterType,
      pageSize: _pageSize,
    );
    if (idols.length < _pageSize) {
      state.pagingController.appendLastPage(idols);
    } else {
      state.pagingController.appendPage(idols, idols.last.name);
    }
  }

  @override
  Future<void> close() {
    state.pagingController.dispose();
    return super.close();
  }
}
