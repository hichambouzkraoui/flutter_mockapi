import 'package:tdd_tutorial/core/utils/typedef.dart';

abstract class useCaseWithParams<Type, Params> {
  
  ResultFuture<Type> call(Params params);
}

abstract class useCaseWithoutParams<Type> {
  
  ResultFuture<Type> call();
}