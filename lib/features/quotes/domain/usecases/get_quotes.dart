import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quote_entity.dart';
import '../repositories/quote_repository.dart';

/// Single-responsibility: fetch a page of quotes.
class GetQuotes extends UseCase<List<QuoteEntity>, GetQuotesParams> {
  final QuoteRepository repository;

  GetQuotes(this.repository);

  @override
  Future<Either<Failure, List<QuoteEntity>>> call(GetQuotesParams params) {
    return repository.getQuotes(limit: params.limit, skip: params.skip);
  }
}

class GetQuotesParams extends Equatable {
  final int limit;
  final int skip;

  const GetQuotesParams({required this.limit, required this.skip});

  @override
  List<Object?> get props => [limit, skip];
}

