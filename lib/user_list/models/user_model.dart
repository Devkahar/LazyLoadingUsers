import 'package:lazy_app/user_list/user_list.dart';

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
