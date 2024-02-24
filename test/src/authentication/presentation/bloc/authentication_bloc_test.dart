import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/bloc/authentication_bloc.dart';

class MockCreateUser extends Mock implements CreateUser {}
class MockGetUsers extends Mock implements GetUsers {}
main() {
  late AuthenticationBloc bloc;
  late MockCreateUser mockCreateUser;
  late MockGetUsers mockGetUsers;
  const createdAt = 'whatever.createdAt';
  const name = 'whatever.name';
  const avatar = 'whatever.avatar';

  setUp(() {
    mockCreateUser = MockCreateUser();
    mockGetUsers = MockGetUsers();
    bloc = AuthenticationBloc(
      createUser: mockCreateUser,
      getUsers: mockGetUsers
      );

    registerFallbackValue(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar
      ));
  });

  test('initial state should be AuthenticationInitial', () {
  // assert
    expect(bloc.state, equals(AuthenticationInitial()));
  });

  group('CreateUser', () {
    test('should create user successfully', () async {
      //arrange
      when(() => mockCreateUser(any())).thenAnswer((_) async => Right(null));
      //act
      bloc.add(const CreateUserEvent(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar
        ));
       await untilCalled(() => mockCreateUser(any()));
      //assert
      verify(() => mockCreateUser(CreateUserParams(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar)));
    });

    test('should emit [CreatingUser, UserCreated] when data is gotten successfully', ()async  {
      when(() => mockCreateUser(any())).thenAnswer((_) async => Right(null));
      final expected = [
        CreatingUser(),
        UserCreated()
      ];
      //act
      bloc.add(const CreateUserEvent(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar
        ));
      // assert
      expectLater(bloc.stream, emitsInOrder(expected));
    });

    test('should emit [CreatingUser, AuthenticationError] when getting data fails', ()async  {
      //arrange
      const message = 'api error';
      const statusCode = 500;
      when(() => mockCreateUser(any())
      ).thenAnswer((_) async => Left(ApiFailure(message: message, statusCode: statusCode)));
      final expected = [
        CreatingUser(),
        AuthenticationError(message)
      ];
      //act
      bloc.add(const CreateUserEvent(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar
        ));
      // assert
      expectLater(bloc.stream, emitsInOrder(expected));
    });
  });

}