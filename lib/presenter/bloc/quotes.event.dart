

abstract class QuoteEvent {
  const QuoteEvent();
}

class GetQuotesEvent extends QuoteEvent {
}


class LoadMoreQuotesEvent extends QuoteEvent {
}