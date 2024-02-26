import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/loading_column.dart';

import '../widgets/add_user_dialog.dart';
import '../widgets/users_loaded_view.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }
  @override
  void initState() {
    super.initState();
    getUsers();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is AuthenticationError) {
          ScaffoldMessenger.of(context)
                           .showSnackBar(
                              SnackBar(content: Text(state.message))
                            );
        } else if(state is UserCreated) {
            getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: buildBody(state),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(context: context, builder: (context) => AddUserDialog(nameController:nameController));
            },
            icon: const Icon(Icons.add),
            label: const Text('Add User'),),
        );
      },
    );
  }

  Widget buildBody( AuthenticationState state) {
      if(state is GettingUsers) {
          return  const LoadingColumn(message: 'Fetching users ...');
      } else if(state is CreatingUser) {
          return  const LoadingColumn(message: 'Creating user ...');
      } else if( state is UsersLoaded) {
          return UsersLoadedView(users: state.users);
      } else {
        return const SizedBox.shrink();
      }
  }
}