import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id, 
    required super.createdAt, 
    required super.name, 
    required super.avatar
  });
  
  factory UserModel.fromJson(String source) =>
    UserModel.fromMap(jsonDecode(source) as DataMap);
  
  UserModel.fromMap(DataMap map):
    this(
      avatar: map['avatar'] as String,
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
    );
  
  UserModel copyWith({
    String? id,
    String? avatar, 
    String? createdAt, 
    String? name
  }) => UserModel(
    id: id ?? this.id, 
    avatar: avatar ?? this.avatar,
    createdAt: createdAt ?? this.createdAt, 
    name: name ?? this.name
  );

  UserModel.empty():
    this(
      id: '0',
      createdAt: '_empty.createdAt', 
      name: '_empty.name', 
      avatar: '_empty.avatar'
    );

  DataMap toMap() => {
    'id': id,
    'avatar' : avatar,
    'createdAt': createdAt,
    'name': name
  };

  String toJson() => jsonEncode(toMap());
  
}