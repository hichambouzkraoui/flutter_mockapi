
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockCreateUser extends Mock implements CreateUser {}
class MockGetUsers extends Mock implements GetUsers {}
main() {

  late AuthenticationCubit cubit;
  late MockCreateUser mockCreateUser;
  late MockGetUsers mockGetUsers;
  const createdAt = 'whatever.createdAt';
  const name = 'whatever.name';
  const avatar = 'whatever.avatar';

  setUp(() {
    mockCreateUser = MockCreateUser();
    mockGetUsers = MockGetUsers();
    cubit = AuthenticationCubit(
      createUser: mockCreateUser,
      getUsers: mockGetUsers
    );

    registerFallbackValue(const CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar
      ));

  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, AuthenticationInitial());
  });

  group('createUser', () { 
    const message = 'api error';
    const statusCode = 500;

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should create user successfully',
      build: () {
        when(() => mockCreateUser(any())).thenAnswer((_) async => Right(null));
        return cubit;
      } ,
      act: (cubit) => cubit.createUser(
        createdAt:createdAt,
        name: name,
        avatar: avatar),
      verify: (_) {
        verify(() => mockCreateUser(const CreateUserParams(
          createdAt: createdAt, 
          name: name, 
          avatar: avatar))).called(1);
        verifyNoMoreInteractions(mockCreateUser);
      } 
    );
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, UserCreated] when data is gotten successfully',
      build: () {
        when(() => mockCreateUser(any())).thenAnswer((_) async => Right(null));
        return cubit;
      } ,
      act: (cubit) => cubit.createUser(
        createdAt:createdAt,
        name: name,
        avatar: avatar),
      expect: () => [CreatingUser(),UserCreated()]
    );
  blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, AuthenticationError] when getting data fails',
      build: () {
        when(() => mockCreateUser(any())
        ).thenAnswer((_) async => Left(ApiFailure(message: message, statusCode: statusCode)));
        return cubit;
      } ,
      act: (cubit) => cubit.createUser(
        createdAt:createdAt,
        name: name,
        avatar: avatar),
      expect: () => [CreatingUser(),AuthenticationError(message)]
    );
  });

  group('getUsers', () {
    const message = 'api error';
    const statusCode = 500;
    const tUsers = [User.empty()];
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should get usesr successfully',
      build: () {
        when(() => mockGetUsers()).thenAnswer((_) async => Right(tUsers));
        return cubit;
      } ,
      act: (cubit) => cubit.getUsers(),
      verify: (_) {
        verify(() => mockGetUsers()).called(1);
        verifyNoMoreInteractions(mockGetUsers);
      } 
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should get users successfully',
      build: () {
        when(() => mockGetUsers()).thenAnswer((_) async => Right(tUsers));
        return cubit;
      } ,
      act: (cubit) => cubit.getUsers(),
      verify: (_) {
        verify(() => mockGetUsers()).called(1);
        verifyNoMoreInteractions(mockGetUsers);
      } 
    );
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, UsersLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetUsers()).thenAnswer((_) async => Right(tUsers));
        return cubit;
      } ,
      act: (cubit) => cubit.getUsers(),
      expect: () => [GettingUsers(),UsersLoaded(tUsers)]
    );

  });
}