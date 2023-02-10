import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:quote_app/domain/entities/quote.dart';
import 'package:quote_app/domain/usecases/get_quotes.usecase.dart';
import 'package:quote_app/presenter/bloc/quotes.event.dart';
import 'package:quote_app/presenter/bloc/quotes.state.dart';

class QuotesBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetQuotesUsecase usecase;
  final listController = ScrollController();
  List<Quote> quotes = [];
  int page = 1;
  int totalPages = 0;
  QuotesBloc({required this.usecase}) : super(Empty()) {
    on<QuoteEvent>(
      ((event, emit) async {
        if (event is GetQuotesEvent) {
          emit(Loading());
          final result = await usecase.call(page, 10);
          page++;
          result.fold((l) => emit(const Error(message: 'Server ERROR')), (r) {
            totalPages = r.totalPages;
            quotes.addAll(r.quotes);
            emit(Success(quotes: quotes));
          });
        }

        if (event is LoadMoreQuotesEvent) {
          if (page == totalPages) {
            return;
          }
          emit(LoadingMore());
          final result = await usecase.call(page, 10);
          page++;
          result.fold((l) => emit(const Error(message: 'Server ERROR')), (r) {
            quotes.addAll(r.quotes);
            emit(Success(quotes: quotes));
          });
        }
      }),
    );
  }
}
