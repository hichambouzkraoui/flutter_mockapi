import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/errors/exception.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;
  const Failure({
    required this.message,
    required this.statusCode
  });

  @override
  List<Object> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});
  ApiFailure.fromException(ApiException exception):
    this(message: exception.message, statusCode: exception.statusCode);
  
}