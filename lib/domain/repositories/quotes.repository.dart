import 'package:dartz/dartz.dart';
import 'package:quote_app/data/datasources/quotes.datasource.dart';
import 'package:quote_app/failures.dart';

abstract class IQuotesRepository {
  Future<Either<Failure, ResultApi>> getQuotes(int page, int limit);
}
