part of 'user_list_controller.dart';

enum UserListStatus {
  initial,
  fetchingUserList,
  fetchUserListSuccess,
  fetchUserListError,
  fetchingMoreUsers,
  fetchMoreUsersError,
  fetchMoreUsersSuccess,
  refreshingUsers,
  refreshUsersSuccess,
  refreshUsersError,
}

class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.message = '',
    this.users = const [],
    this.page = 1,
    this.isLastPage = false,
  });

  final UserListStatus status;
  final String message;
  final List<User> users;
  final int page;
  final bool isLastPage;

  UserListState copyWith({
    UserListStatus? status,
    String? message,
    List<User>? users,
    int? page,
    bool? isLastPage,
  }) {
    return UserListState(
      status: status ?? this.status,
      message: message ?? this.message,
      users: users ?? this.users,
      page: page ?? this.page,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [status, message, users, page, isLastPage];
}
