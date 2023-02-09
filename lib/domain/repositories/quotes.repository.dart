import 'package:dartz/dartz.dart';
import 'package:quote_app/domain/entities/quote.dart';
import 'package:quote_app/failures.dart';

abstract class IQuotesRepository {
  Future<Either<Failure, List<Quote>>> getQuotes(int page, int limit);
}
