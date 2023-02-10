import 'package:flutter/material.dart';
import 'package:quote_app/dependecy_injection.dart' as di;
import 'package:quote_app/presenter/pages/quotes.page.dart';

void main() async {
  await di.init();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.green.shade600),
      ),
      home: const QuotesPage(),
    );
  }
}
