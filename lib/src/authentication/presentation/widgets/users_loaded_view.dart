import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/user.dart';

class UsersLoadedView extends StatelessWidget {
  final List<User> users;
  const UsersLoadedView({super.key, required this.users});
  @override
  Widget build(BuildContext context) {
    return  Center(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) =>  ListTile(
                  leading: Image.network(users[index].avatar),
                  title: Text(users[index].name),
                  subtitle: Text(users[index].createdAt.substring(0,19)),

                ),
                ),
          );
  }
}