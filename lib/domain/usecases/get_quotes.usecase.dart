import 'package:dartz/dartz.dart';
import 'package:quote_app/domain/entities/quote.dart';
import 'package:quote_app/domain/repositories/quotes.repository.dart';
import 'package:quote_app/failures.dart';

class GetQuotesUsecase {
  final IQuotesRepository repository;
  GetQuotesUsecase(this.repository);

  Future<Either<Failure, List<Quote>>> call(int page, int limit) async {
    return await repository.getQuotes(page, limit);
  }
}

