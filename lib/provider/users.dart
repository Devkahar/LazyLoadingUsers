import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

/*
class Users extends ChangeNotifier {
  final List<User> _usersList = [];
  int _page = 1;

  List<User> get usersList => _usersList;

  final _resultsPerPage = 15;

  final client = http.Client();

  Future<void> loadUsers() async {
    try {
      final url = Uri.parse(
          'https://randomuser.me/api/?page=$_page&results=$_resultsPerPage&seed=abc');

      final res = await client.get(url);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as Map<String, dynamic>;
        // print(data);
        final loadedData = data['results'] as List<dynamic>;
        for (var element in loadedData) {
          final user = User.fromJson(element);
          usersList.add(user);
        }
        _page++;
        // print(usersList);
        notifyListeners();
      } else {
        throw 'Failed to fetch users.';
      }
    } catch (error) {
      print(error);
    }
  }

  refresh() async {
    _page = 1;
    usersList.clear();
    await loadUsers();
  }
}
final usersProvider = ChangeNotifierProvider((ref) {
  return Users();
});*/
