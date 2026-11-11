import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quote_bloc.dart';
import '../bloc/quote_event.dart';
import '../bloc/quote_state.dart';
import '../widgets/quote_card.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<QuoteBloc>().add(FetchQuotes());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<QuoteBloc>().add(FetchQuotes());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quotes')),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          switch (state.status) {
            case QuoteStatus.initial:
            case QuoteStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case QuoteStatus.error:
              return Center(child: Text('Error: ${state.errorMessage}'));

            case QuoteStatus.loaded:
              if (state.quotes.isEmpty) {
                return const Center(child: Text('No quotes found'));
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.quotes.length
                    : state.quotes.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.quotes.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return QuoteCard(quote: state.quotes[index]);
                },
              );
          }
        },
      ),
    );
  }
}

