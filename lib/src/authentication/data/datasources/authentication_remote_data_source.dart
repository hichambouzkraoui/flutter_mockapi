import 'dart:convert';

import 'package:http/http.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
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
          }),
          headers: {
            'Content-Type': 'application/json'
          }
      );
      if(response.statusCode != 200 && response.statusCode != 201 ) {

        throw ApiException(
          message: response.body, 
          statusCode: response.statusCode
        );
      }
    } on ApiException{
        rethrow;
    } on Exception {
        throw const ApiException(
          message:'Unknown error', 
          statusCode: 500
        );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      Response response = await _client.get(Uri.parse(kAuthenticationUrl));
      if(response.statusCode == 200) {
        return List<DataMap>.from((jsonDecode(response.body) as List))
                        .map((userData) => UserModel.fromMap(userData))
                        .toList();
      } else {
          throw ApiException(
            message: response.body, 
            statusCode: response.statusCode
          );
      }

    } on ApiException {
      rethrow;
    } on Exception {
        throw const ApiException(
          message:'Unknown error', 
          statusCode: 500
        );
    }
  }
  
}