import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exception.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/errors/failure.dart';

class AuthenticationRepositoryImpl implements AuthenticationRespository {
  final AuthenticationRemoteDataSource _remoteDataSource;
  AuthenticationRepositoryImpl(this._remoteDataSource);
  
  @override
  ResultFuture<void> createUser({
    required createdAt, 
    required name, 
    required avatar
  }) async {
    try {
      await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
      return Right(null);
    } on ApiException catch(e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      List<User> users = await _remoteDataSource.getUsers();
      return Right(users);
    } on ApiException catch(e) {
      return Left(ApiFailure.fromException(e));
    }

  }
  
}