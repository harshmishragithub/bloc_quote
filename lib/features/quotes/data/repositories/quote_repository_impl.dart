import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/quote_entity.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_remote_datasource.dart';

/// Implements the domain contract. Catches exceptions → returns Failures.
class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<QuoteEntity>>> getQuotes({
    required int limit,
    required int skip,
  }) async {
    try {
      final quotes = await remoteDataSource.getQuotes(
        limit: limit,
        skip: skip,
      );
      return Right(quotes);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

