part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();  

  @override
  List<Object> get props => [];
}
class AuthenticationInitial extends AuthenticationState {}

class CreatingUser extends AuthenticationState {}

class GettingUsers extends AuthenticationState {}

class UserCreated extends AuthenticationState {}

class UsersLoaded extends AuthenticationState {
  final List<User> users;
  
  const UsersLoaded(this.users);
  
  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);
    @override
  List<Object> get props => [message];

}
