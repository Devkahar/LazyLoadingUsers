import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_app/user_list/repository/user_list_repository.dart';

import 'package:equatable/equatable.dart';

import 'package:lazy_app/user_list/user_list.dart';

part 'user_list_state.dart';

final userListControllerProvider =
    StateNotifierProvider.autoDispose<UserListController, UserListState>(
  (ref) => UserListController(
    repository: ref.read(userListRepositoryProvider),
  )..fetchUserList(),
);

class UserListController extends StateNotifier<UserListState> {
  UserListController({
    required UserListRepository repository,
  })  : _repository = repository,
        super(const UserListState());

  final UserListRepository _repository;

  final resultsPerPage = 15;

  Future<void> fetchUserList() async {
    try {
      state = state.copyWith(
        status: UserListStatus.fetchingUserList,
      );

      final response = await _repository.fetchUserList(
        page: state.page,
        resultsPerPage: resultsPerPage,
      );

      state = state.copyWith(
        status: UserListStatus.fetchUserListSuccess,
        users: response.results,
        page: state.page + 1,
        isLastPage: state.page == 5,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserListStatus.fetchUserListError,
        message: e.toString(),
      );
    }
  }

  Future<void> refreshUserList() async {
    try {
      state = state.copyWith(
        status: UserListStatus.refreshingUsers,
        page: 1,
      );

      final response = await _repository.fetchUserList(
        page: state.page,
        resultsPerPage: resultsPerPage,
      );

      state = state.copyWith(
        status: UserListStatus.refreshUsersSuccess,
        users: response.results,
        page: state.page + 1,
        isLastPage: state.page == 5,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserListStatus.refreshUsersError,
        message: e.toString(),
      );
    }
  }

  Future<void> fetchMoreUsers() async {
    try {
      if (state.isLastPage ||
          state.status == UserListStatus.fetchingMoreUsers) {
        return;
      }

      state = state.copyWith(
        status: UserListStatus.fetchingMoreUsers,
      );

      final response = await _repository.fetchUserList(
        page: state.page,
        resultsPerPage: resultsPerPage,
      );

      state = state.copyWith(
        status: UserListStatus.refreshUsersSuccess,
        users: [...state.users, ...response.results],
        page: state.page + 1,
        isLastPage: state.page == 5,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserListStatus.fetchMoreUsersError,
        message: e.toString(),
      );
    }
  }
}
