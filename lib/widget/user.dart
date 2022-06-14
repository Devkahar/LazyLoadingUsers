import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String fullName;
  final String imageUrl;

  const UserCard({
    Key? key,
    required this.fullName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(imageUrl),
      ),
      title: Text(fullName),
    );
  }
}
