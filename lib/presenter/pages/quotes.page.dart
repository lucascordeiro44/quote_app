import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/dependecy_injection.dart';
import 'package:quote_app/presenter/bloc/quotes.bloc.dart';
import 'package:quote_app/presenter/bloc/quotes.event.dart';
import 'package:quote_app/presenter/bloc/quotes.state.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final _bloc = getIt.get<QuotesBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetQuotesEvent());
    _bloc.listController.addListener(_loadMore);
  }

  _loadMore() {
    if (_bloc.listController.offset >= _bloc.listController.position.maxScrollExtent) {
      setState(() {
        _bloc.add(LoadMoreQuotesEvent());
      });

     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Quotes Page")),
        body: BlocBuilder<QuotesBloc, QuoteState>(
          builder: (context, state) {
            if (state is Empty) {
              return const Center(
                child: Text('Nothing'),
              );
            }

            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }

             if (state is LoadingMore) {
                    return const Center(child: CircularProgressIndicator());
                  }

            if (state is Success) {
              return ListView.builder(
                controller: _bloc.listController,
                itemCount: state.quotes.length,
                itemBuilder: (context, index) {
                  if (state is LoadingMore) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _itemCard(state, index);
                },
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
          bloc: _bloc,
        ));
  }

  _itemCard(Success state, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(state.quotes[index].author ?? "Empty"),
            subtitle: Text(state.quotes[index].content ?? "Empty"),
          ),
        ),
      ),
    );
  }
}
