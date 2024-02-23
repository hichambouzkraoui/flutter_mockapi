import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  UserModel tUserModel = UserModel.empty();
  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  test('should be a subclass of entity',() {
    //arrange
    //act
   // assert
   expect(tUserModel, isA<User>());
  });
  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      //arrange
      //act
      final result = UserModel.fromMap(tMap);
      //assert
      expect(result, tUserModel);

      
    });
    
  });
  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      //arrange
      final tJson = fixture('user.json');
      //act
      final result = UserModel.fromJson(tJson);
      //assert
      expect(result, tUserModel);

      
    });
    
  });
  group('toMap', () {
    test('should return a [Map] with right data', () {
      //arrange
      //act
      final result = tUserModel.toMap();
      //assert
      expect(result, tMap);
    });
  
  group('toJson', () {
    test('should return a [JSON] with right data', () {
      //arrange
      final tJson = jsonEncode(
        {
        "id": "0",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
        }
      );
      //act
      final result = tUserModel.toJson();
      //assert
      expect(result, tJson);

    });
    
  });

  group('copyWith', () {
    test('should return a [userModel] with different data', () {
      //arrange
      final oldName = tUserModel.name;
      final newName = 'newName';
      //act
      final result = tUserModel.copyWith(name: newName);
      //assert
      expect(result.name, newName);
      expect(tUserModel.name, oldName);
      
    });
   });
    
  });
}