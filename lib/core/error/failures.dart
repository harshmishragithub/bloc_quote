import 'package:equatable/equatable.dart';

/// Base class for all failures in the app.
/// Every failure type extends this so BLoC can pattern-match.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Thrown when a network/API call fails.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

