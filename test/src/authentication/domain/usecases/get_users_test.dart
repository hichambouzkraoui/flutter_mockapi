import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRespository respository;
  setUp(() {
    respository = MockAuthenticationRespository();
    usecase = GetUsers(respository);
  });
  const tResponse = [User.empty()];
  test('should call [AuthenticationRespository.getUsers]',() async {
    when(() => respository.getUsers()).thenAnswer((_) async => Right(tResponse));
    final result = await usecase();
    verify(() => respository.getUsers()).called(1);
    verifyNoMoreInteractions(respository);
    expect(result, Right(tResponse));
  });
}