import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/exception.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}
void main() {
  late MockHttpClient client;
  late AuthenticationRemoteDataSource remoteDataSource;
  setUpAll(() {
    client = MockHttpClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });
  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test('should complete successfully when the status code is 200 or 201', () async {
      //arrange
      when(() => client.post(any(),body: any(named: 'body'),headers: any(named: 'headers'))
      ).thenAnswer((_) async => http.Response('user created successfully',200));
      //act
      final call = remoteDataSource.createUser(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar
      );
      //assert
      expectLater(call, completes);

      verify(() => client.post(
        Uri.parse(kAuthenticationUrl),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
         // 'avatar': avatar
        }),
        headers: {
          'Content-Type': 'application/json'
        }
      )).called(1);
      
    });
    test('should return [ApiException] when status code is not 200 or 201', () async {
      //arrange
      when(() => client.post(any(),body: any(named: 'body'), headers: any(named: 'headers'))
      ).thenAnswer((_) async => http.Response('api error',500));
      // act
      final call = remoteDataSource.createUser(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar
      );

      //assert
      expectLater(call, throwsA(ApiException(message: 'api error', statusCode: 500)));
      
      verify(() => client.post(
        Uri.parse(kAuthenticationUrl),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          //'avatar': avatar
        }),
        headers: {
          'Content-Type': 'application/json'
        }
      )).called(1);
    });

    test('should return [ApiException] when http call fails', () async {
      //arrange
      when(() => client.post(any(),body: any(named: 'body'), headers: any(named: 'headers'))
      ).thenThrow(Exception());
      // act
      final call = remoteDataSource.createUser(
        createdAt: createdAt, 
        name: name, 
        avatar: avatar
      );

      expectLater(call, throwsA(ApiException(message: 'Unknown error', statusCode: 500)));
      
      verify(() => client.post(
        Uri.parse(kAuthenticationUrl),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          //'avatar': avatar
        }),
        headers: {
          'Content-Type': 'application/json'
        }
      )).called(1);
    }); 
  });
   group('getUsers', () {
    final tUserModel =UserModel.empty();

    test('should complete successfully when the status code is 200 or 201', () async {
      //arrange
      when(() => client.get(any())
      ).thenAnswer((_) async => http.Response(jsonEncode([tUserModel.toMap()]), 200));
      //act
      final call = remoteDataSource.getUsers();
      //assert
      expectLater(call, completes);

      verify(() => client.get(Uri.parse(kAuthenticationUrl))).called(1);
      
    });

    test('should return [ApiException] when status code is not 200', () async {
      //arrange
      when(() => client.get(any())
      ).thenAnswer((_) async => http.Response('api error',500));
      //act
      final call = remoteDataSource.getUsers();
      //assert
      expectLater(call, throwsA(ApiException(message: 'api error', statusCode: 500)));

      verify(() => client.get(Uri.parse(kAuthenticationUrl))).called(1);
      
    });

    test('should return [ApiException] when http call fails', () async {
      //arrange
      when(() => client.get(any())
      ).thenThrow(Exception());
      //act
      final call = remoteDataSource.getUsers();
      //assert
      expectLater(call, throwsA(ApiException(message: 'Unknown error', statusCode: 500)));

      verify(() => client.get(Uri.parse(kAuthenticationUrl))).called(1);
      
    });
});
  
}