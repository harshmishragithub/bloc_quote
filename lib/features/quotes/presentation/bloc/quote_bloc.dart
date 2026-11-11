import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/constants/api_constants.dart';
import '../../domain/usecases/get_quotes.dart';
import 'quote_event.dart';
import 'quote_state.dart';

/// Debounce transformer — prevents spamming API on rapid scroll.
EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>()(events.debounce(duration), mapper);
  };
}

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetQuotes _getQuotes;

  QuoteBloc(this._getQuotes) : super(const QuoteState()) {
    on<FetchQuotes>(
      _onFetchQuotes,
      transformer: debounceDroppable(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetchQuotes(
    FetchQuotes event,
    Emitter<QuoteState> emit,
  ) async {
    if (state.hasReachedMax) return;

    if (state.status == QuoteStatus.initial) {
      emit(state.copyWith(status: QuoteStatus.loading));
    }

    final result = await _getQuotes(
      GetQuotesParams(
        limit: ApiConstants.pageLimit,
        skip: state.page * ApiConstants.pageLimit,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: QuoteStatus.error,
        errorMessage: failure.message,
      )),
      (quotes) => emit(state.copyWith(
        status: QuoteStatus.loaded,
        quotes: List.of(state.quotes)..addAll(quotes),
        hasReachedMax: quotes.length < ApiConstants.pageLimit,
        page: state.page + 1,
      )),
    );
  }
}
