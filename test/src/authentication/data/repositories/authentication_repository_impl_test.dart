import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exception.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_impl.dart';
class MockAuthenticationRemoteDataSource extends Mock implements AuthenticationRemoteDataSource {}
void main() {

  late AuthenticationRepositoryImpl repository;
  late MockAuthenticationRemoteDataSource remoteDataSource;
  setUpAll((){
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repository = AuthenticationRepositoryImpl(remoteDataSource);
    });
  
  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test('should call the [RemoteDataSource.createUser()] and complete succesfully when call to remote datasource is successful', () async {
      //arrange
      when(() => remoteDataSource.createUser(
        createdAt: any(named: 'createdAt'), 
        name: any(named: 'name'), 
        avatar: any(named: 'avatar'))
      ).thenAnswer((_) async => {});

      //act
      final result = await repository.createUser(createdAt: createdAt, name: name, avatar: avatar);
      //aasert
      verify(() => remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);
      expect(result, Right(null));
    });

    test('should return a [ServerFailure] when call to remote datasource fails ', () async {
      //arrange
      const message = 'error';
      const statusCode = 500;
      when(() => remoteDataSource.createUser(
        createdAt: any(named: 'createdAt'), 
        name: any(named: 'name'), 
        avatar: any(named: 'avatar'))
      ).thenThrow(ApiException(message: message, statusCode:statusCode));
      //act
      final result = await repository.createUser(createdAt: createdAt, name: name, avatar: avatar);
      //assert
      verify(() => remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);
      expect(result, Left(ApiFailure(message: message, statusCode:statusCode)));
    });
  });

  group('getUsers', () {
    final tUserModels = [UserModel.empty()];
    test('should call the [RemoteDataSource.getUsers()] and complete succesfully when call to remote datasource is successful', () async {
      //arrange
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => Future.value(tUserModels));
      //act
      final result = await repository.getUsers();
      //assert
      verify(() => remoteDataSource.getUsers()).called(1);
      expect(result, Right(tUserModels));
    });

    test('should call return [ServerFailure] when call to remote datasource fails', () async {
      //arrange
      const message = 'error';
      const statusCode = 500;
      when(() => remoteDataSource.getUsers()).thenThrow(ApiException(message: message, statusCode:statusCode));
      //act
      final result = await repository.getUsers();
      //assert
      verify(() => remoteDataSource.getUsers()).called(1);
      expect(result, Left(ApiFailure(message: message, statusCode:statusCode)));
    });

  });
}