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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            if (state is Success) {
              return ListView.builder(
                itemCount: state.quotes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.quotes[index].author ?? "Empty"),
                    subtitle: Text(state.quotes[index].content ?? "Empty"),
                  );
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
}
