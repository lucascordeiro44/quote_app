import 'package:bloc/bloc.dart';
import 'package:quote_app/domain/usecases/get_quotes.usecase.dart';
import 'package:quote_app/presenter/bloc/quotes.event.dart';
import 'package:quote_app/presenter/bloc/quotes.state.dart';

class QuotesBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetQuotesUsecase usecase;
  QuotesBloc({required this.usecase}) : super(Empty()) {
    on<QuoteEvent>(((event, emit) async {
      if (event is GetQuotesEvent) {
        emit(Loading());
        final result = await usecase.call(1, 10);
        result.fold((l) => emit(const Error(message: 'Server ERROR')),
            (r) => emit(Success(quotes: r)));
      }
    }));
  }
}
