import 'package:equatable/equatable.dart';

/// All events for the QuoteBloc.
abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

/// Fired on initial load and when user scrolls to the bottom for next page.
class FetchQuotes extends QuoteEvent {}

