import 'package:flutter/material.dart';
import 'package:lazy_app/widget/user.dart';
import 'package:provider/provider.dart';

import '../provider/users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  late final ScrollController _controller;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<Users>(context, listen: false).loadUsers();
    });

    _controller = ScrollController();

    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          loading = true;
        });

        await context.read<Users>().loadUsers();

        setState(() {
          loading = false;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<Users>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<Users>().refresh();
                },
                child: ListView.separated(
                  controller: _controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemBuilder: (ctx, index) {
                    if (index == users.usersList.length && loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final user = users.usersList[index];

                    return UserCard(
                      imageUrl: user.large,
                      fullName: user.fullName,
                    );
                  },
                  separatorBuilder: (ctx, index) => const Divider(
                    height: 10,
                    indent: 78,
                  ),
                  itemCount: loading
                      ? users.usersList.length + 1
                      : users.usersList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
