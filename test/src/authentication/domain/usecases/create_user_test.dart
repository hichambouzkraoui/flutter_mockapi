
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';
 void main() {
  late CreateUser usecase;
  late AuthenticationRespository respository;
  setUp(() {
    respository = MockAuthenticationRespository();
    usecase = CreateUser(respository);
  });
  test('should call [AuthenticationRespository.createUser]',() async {
    //arrange
    const params = CreateUserParams.empty();
    when( () => respository.createUser(
        createdAt: any(named: 'createdAt'), 
        name: any(named: 'name'), 
        avatar: any(named: 'avatar'))
    ).thenAnswer((_) async => Right(null));
    //act
    final result = await usecase(params);
    //assert
    verify(() => respository.createUser(
      createdAt: params.createdAt, 
      name:params.name,avatar: params.avatar
    )).called(1);
    verifyNoMoreInteractions(respository);
    expect(result, const Right<dynamic, void>(null));

  });
 }