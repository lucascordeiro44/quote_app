import 'package:dartz/dartz.dart';
import 'package:quote_app/data/datasources/quotes.datasource.dart';
import 'package:quote_app/domain/repositories/quotes.repository.dart';
import 'package:quote_app/failures.dart';

class GetQuotesUsecase {
  final IQuotesRepository repository;
  GetQuotesUsecase({required this.repository});

  Future<Either<Failure, ResultApi>> call(int page, int limit) async {
    return await repository.getQuotes(page, limit);
  }
}
