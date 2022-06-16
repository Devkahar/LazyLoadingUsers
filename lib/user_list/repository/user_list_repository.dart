import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_app/user_list/user_list.dart';

final userListRepositoryProvider = Provider(
  (ref) => UserListRepository(),
);

class UserListRepository {
  final _client = http.Client();

  Future<UserListResponse> fetchUserList({
    required int page,
    required int resultsPerPage,
  }) async {
    final url = 'https://randomuser.me/api/?page=$page&results=$resultsPerPage&seed=abc';
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = UserListResponse.fromJson(json);
      return result;
    } else {
      throw 'Failed to fetch users.';
    }
  }
}
