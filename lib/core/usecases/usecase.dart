import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Contract for every UseCase in the app.
/// [Type] = return type, [Params] = input params.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use when a UseCase needs no parameters.
class NoParams {
  const NoParams();
}
