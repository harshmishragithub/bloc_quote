import '../../domain/entities/quote_entity.dart';

/// Data model — knows how to parse JSON. Extends the domain entity.
class QuoteModel extends QuoteEntity {
  const QuoteModel({
    required super.id,
    required super.quote,
    required super.author,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as int,
      quote: json['quote'] as String,
      author: json['author'] as String,
    );
  }
}

