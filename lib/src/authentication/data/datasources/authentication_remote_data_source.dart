import 'dart:convert';

import 'package:http/http.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

import '../../../../core/errors/exception.dart';
abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required createdAt, 
    required name, 
    required avatar
  });

  Future<List<UserModel>> getUsers();
}

const kAuthenticationUrl = '${kBaseUrl}/users';
class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final Client _client;

  AuthenticationRemoteDataSourceImpl(this._client);
  @override
  Future<void> createUser({required createdAt, required name, required avatar}) async {
    try {
      Response response = await _client.post(
          Uri.parse(kAuthenticationUrl),
          body: jsonEncode({
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar
          })
      );
      if(response.statusCode != 200 && response.statusCode != 201 ) {
        print(response);
        throw ApiException(
          message: response.body, 
          statusCode: response.statusCode
        );
      }
    } on ApiException{
        rethrow;
    } on Exception {
        throw ApiException(
          message:'Unknown error', 
          statusCode: 500
        );
    }
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
  
}