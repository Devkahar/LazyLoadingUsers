import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final Name name;
  final Picture picture;

  String get fullName => '${name.first} ${name.last}';

  String get large => picture.large;

  const User({
    required this.name,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: Name.fromJson(json['name']),
      picture: Picture.fromJson(
        json['picture'],
      ),
    );
  }
}

class Name {
  final String first;
  final String last;

  const Name({
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        first: json['first'],
        last: json['last'],
      );
}

class Picture {
  final String large;

  const Picture(this.large);

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        json['large'],
      );
}

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
