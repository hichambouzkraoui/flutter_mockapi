import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  UserModel tUserModel = UserModel.empty();
  test('should be a subclass of entity',() {
    //arrange
    //act
   // assert
   expect(tUserModel, isA<User>());
  });
  group('fromMap', () {
    test('should return a [UserModel with the right data]', () {
      //arrange
      final tJson = fixture('user.json');
      final tMap = jsonDecode(tJson) as DataMap;
      //act
      final result = UserModel.fromMap(tMap);
      //assert
      expect(result, tUserModel);

      
    });
    
  });
  group('fromJson', () {
    test('should return a [UserModel with the right data]', () {
      //arrange
      final tJson = fixture('user.json');
      //act
      final result = UserModel.fromJson(tJson);
      //assert
      expect(result, tUserModel);

      
    });
    
  });
}