import 'package:get_it/get_it.dart';
import 'package:quote_app/data/datasources/quotes.datasource.dart';
import 'package:quote_app/data/repositories/quotes.repository_impl.dart';
import 'package:quote_app/domain/repositories/quotes.repository.dart';
import 'package:quote_app/domain/usecases/get_quotes.usecase.dart';
import 'package:quote_app/presenter/bloc/quotes.bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

init() async {
//usecase
  getIt.registerLazySingleton(() => GetQuotesUsecase(repository: getIt()));

  //repository
 getIt.registerLazySingleton<IQuotesRepository>(() => QuotesRepository(datasource: getIt()));

 //datasource
 getIt.registerLazySingleton<IQuotesDatasource>(() => QuotesDatasourceImpl(client:  getIt()));

 getIt.registerLazySingleton(() => http.Client());

  //Bloc
  getIt.registerFactory(() => QuotesBloc(usecase: getIt()));
}
