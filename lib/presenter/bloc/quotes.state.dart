import 'package:quote_app/domain/entities/quote.dart';

abstract class QuoteState {
  const QuoteState();
}

class Empty extends QuoteState {

}

class Loading extends QuoteState {

}

class Success extends QuoteState {
  final List<Quote> quotes;
  const Success({required this.quotes});

}

class Error extends QuoteState {
  final String message;
  const Error({required this.message});

}

