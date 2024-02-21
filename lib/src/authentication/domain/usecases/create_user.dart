import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/usecases/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser  extends useCaseWithParams<void,CreateUserParams>{
  final AuthenticationRespository _repisitory;
  
  CreateUser(this._repisitory);

  ResultFuture<void> call(CreateUserParams params) async => _repisitory.createUser(
    createdAt: params.createdAt, 
    name: params.name, 
    avatar: params.avatar
  );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String  name;
  final String avatar;

  const CreateUserParams({required this.createdAt, required this.name, required this.avatar});
  
  const CreateUserParams.empty():
    this(
      createdAt: '_empty.createdAt', 
      name: '_empty.name', 
      avatar: '_empty.avatar');

  @override
  List<Object?> get props => [createdAt, name, avatar];
  
}