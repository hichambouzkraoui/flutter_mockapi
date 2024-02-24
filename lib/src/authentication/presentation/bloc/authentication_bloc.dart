import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser createUser;
  final GetUsers getUsers;
  AuthenticationBloc({
    required this.createUser,
    required this.getUsers
  }) : super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserEventHandler);
    on<GetUsersEvent>(_getUserEventHandler);
  }

  _createUserEventHandler(CreateUserEvent event ,Emitter<AuthenticationState> emit) async {
      emit(CreatingUser());
      final Either<Failure,void> result = await createUser(CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar
      ));

      result.fold(
        (failure) => emit(AuthenticationError(failure.message)), 
        (_) => emit(UserCreated())
      );
  }

  _getUserEventHandler(event,emit) async {
    emit(GettingUsers());
    final Either<Failure,List<User>> result = await getUsers();
    result.fold(
      (failure) => emit(AuthenticationError(failure.message)), 
      (users) => emit(UsersLoaded(users))
    );

  }
  
}
