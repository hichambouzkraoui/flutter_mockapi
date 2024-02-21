import 'package:tdd_tutorial/core/usecases/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';

import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class GetUsers extends useCaseWithoutParams<List<User>> {
  final AuthenticationRespository _repisitory;
  
  GetUsers(this._repisitory);

  @override
  ResultFuture<List<User>> call() async => _repisitory.getUsers();
  
}