import 'package:quote_app/data/datasources/quotes.datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:quote_app/domain/repositories/quotes.repository.dart';
import 'package:quote_app/failures.dart';

class QuotesRepository implements IQuotesRepository {
  final IQuotesDatasource datasource;

  QuotesRepository({required this.datasource});

  @override
  Future<Either<Failure, ResultApi>> getQuotes(int page, int limit) async {
    try {
      final ResultApi result = await datasource.getQuotes(page, limit);
      return right(result);
    } catch (e) {
      return left(Failure());
    }
  }
}
