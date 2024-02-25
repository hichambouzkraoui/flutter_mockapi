import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers
  }) : 
    _createUser = createUser,
    _getUsers = getUsers,
    super(AuthenticationInitial());

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar
  }) async {
    emit(CreatingUser());
    final result = await _createUser(CreateUserParams(
      createdAt: createdAt, 
      name: name, 
      avatar: avatar));
    result.fold(
      (failure) => emit(AuthenticationError(failure.message)), 
      (_) => emit(UserCreated())
    );
  }

  Future<void> getUsers() async {
    emit(GettingUsers());
    final result = await _getUsers();
    result.fold(
      (failure) => emit(AuthenticationError(failure.message)), 
      (users) => emit(UsersLoaded(users))
    );

  }
}
