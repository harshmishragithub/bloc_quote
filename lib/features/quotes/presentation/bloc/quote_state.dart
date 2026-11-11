import 'package:equatable/equatable.dart';
import '../../domain/entities/quote_entity.dart';

enum QuoteStatus { initial, loading, loaded, error }

class QuoteState extends Equatable {
  final QuoteStatus status;
  final List<QuoteEntity> quotes;
  final bool hasReachedMax;
  final String errorMessage;
  final int page;

  const QuoteState({
    this.status = QuoteStatus.initial,
    this.quotes = const [],
    this.hasReachedMax = false,
    this.errorMessage = '',
    this.page = 0,
  });

  QuoteState copyWith({
    QuoteStatus? status,
    List<QuoteEntity>? quotes,
    bool? hasReachedMax,
    String? errorMessage,
    int? page,
  }) {
    return QuoteState(
      status: status ?? this.status,
      quotes: quotes ?? this.quotes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [status, quotes, hasReachedMax, errorMessage, page];
}

