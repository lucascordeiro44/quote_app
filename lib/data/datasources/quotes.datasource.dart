import 'dart:convert';
import 'package:quote_app/domain/entities/quote.dart';
import 'package:http/http.dart' as http;

abstract class IQuotesDatasource {
  Future<List<Quote>> getQuotes(int page, int limit);
}

class QuotesDatasource implements IQuotesDatasource {
  final http.Client client;

  QuotesDatasource(this.client);
  
  @override
  Future<List<Quote>> getQuotes(int page, int limit) async {
    try {
      final response = await http
          .get(Uri.parse("https://quotable.io/quotes?page=$page&limit=$limit"));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List results = json['results'] as List;
        int totalPages = json['totalPages'];
        List<Quote> quotes = results
            .map(
              (e) => Quote.fromJson(e),
            )
            .toList();
        return quotes;
      }
      throw Exception('Failed to load quotes');
    } catch (e) {
      throw Exception(e);
    }
  }
}
