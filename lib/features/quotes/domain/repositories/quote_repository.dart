import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/quote_entity.dart';

/// Repository contract — domain layer defines WHAT, data layer defines HOW.
abstract class QuoteRepository {
  Future<Either<Failure, List<QuoteEntity>>> getQuotes({
    required int limit,
    required int skip,
  });
}

