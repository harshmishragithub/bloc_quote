import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/quote_model.dart';

/// Contract for remote data source.
abstract class QuoteRemoteDataSource {
  Future<List<QuoteModel>> getQuotes({required int limit, required int skip});
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final Dio dio;

  QuoteRemoteDataSourceImpl(this.dio);

  @override
  Future<List<QuoteModel>> getQuotes({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.quotes,
        queryParameters: {'limit': limit, 'skip': skip},
      );

      final data = response.data as Map<String, dynamic>;
      final quotes = (data['quotes'] as List)
          .map((json) => QuoteModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return quotes;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong');
    }
  }
}

