import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;
  const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child:Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'username',
                   ),
              ),
              ElevatedButton(
                onPressed: () {
                  final name =  nameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                    createdAt: DateTime.now().toString(), 
                    name: name, 
                    avatar: ''
                  );
                  nameController.clear();
                  Navigator.of(context).pop();
                }, 
                child: const Text('Create User')
              )
            ],
          )
        ,) ),
    );
  }
}