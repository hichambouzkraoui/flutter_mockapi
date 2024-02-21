import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';

import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

abstract class AuthenticationRespository {
  const AuthenticationRespository();
  
  ResultFuture<void> createUser({ 
    required createdAt, 
    required name, 
    required avatar
  });

  ResultFuture<List<User>> getUsers();

}