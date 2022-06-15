import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lazy_app/user_list/user_list.dart'
    show UserListStatus, userListControllerProvider;

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final userListState = ref.watch(userListControllerProvider);

          final status = userListState.status;

          if (status == UserListStatus.fetchingUserList) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == UserListStatus.fetchUserListError) {
            return Center(
              child: Text(userListState.message),
            );
          } else {
            final users = userListState.users;

            if (users.isEmpty) {
              return const Center(
                child: Text('No users found.'),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  ref
                      .read(userListControllerProvider.notifier)
                      .fetchMoreUsers();
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(userListControllerProvider.notifier)
                      .refreshUserList();
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == users.length) {
                      return const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }

                    final user = users[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.large),
                      ),
                      title: Text(user.fullName),
                    );
                  },
                  itemCount: status == UserListStatus.fetchingMoreUsers
                      ? users.length + 1
                      : users.length,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
