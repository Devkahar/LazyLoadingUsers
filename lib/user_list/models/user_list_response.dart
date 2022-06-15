import 'package:lazy_app/user_list/user_list.dart';

class UserListResponse {
  const UserListResponse({
    this.results = const [],
  });

  final List<User> results;

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      UserListResponse(
        results: json['results'] == null
            ? []
            : List<User>.from(
                (json['results'] as List<dynamic>).map(
                  (e) => User.fromJson(e),
                ),
              ),
      );
}
