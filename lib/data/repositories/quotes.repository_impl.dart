import 'package:quote_app/data/datasources/quotes.datasource.dart';
import 'package:quote_app/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';
import 'package:quote_app/domain/repositories/quotes.repository.dart';
import 'package:quote_app/failures.dart';

class QuotesRepository implements IQuotesRepository {

  final IQuotesDatasource datasource;

  QuotesRepository(this.datasource);

  @override
  Future<Either<Failure, List<Quote>>> getQuotes(int page, int limit) async {
    try {
      final List<Quote> quotes = await datasource.getQuotes(page, limit);
      return right(quotes);
    } catch (e) {
      return left(Failure());
    }
  }
}
