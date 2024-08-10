import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/home/widgets/expanded_box_list.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_state.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class SplitNavPage extends StatefulWidget {
  const SplitNavPage({super.key});

  @override
  State<SplitNavPage> createState() => _SplitNavPageState();
}

class _SplitNavPageState extends State<SplitNavPage> {
  List<SplitModel> splits = [];
  @override
  void initState() {
    super.initState();
    context.read<SplitBloc>().add(FetchAllSplitRequested());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<SplitBloc, SplitState>(
            builder: (context, state) {
              if (state is SplitLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SplitsLoaded) {
                splits = state.splits;
                if (splits.isEmpty) {
                  return const Center(child: Text('No splits available.'));
                } else {
                  double totalSpent = 0.0;
                  for (SplitModel split in splits) {
                    totalSpent += split.totalAmount;
                  }

                  List<Map<String, String>> stats = [
                    {'title': 'Total Spent', 'value': totalSpent.toString()},
                    {'title': 'Total Tags', 'value': "0"},
                    {'title': 'Total Expenses', 'value': "0"},
                    {'title': 'Popular Tags', 'value': "0"},
                    {'title': 'Most Expensive Expense', 'value': "0"},
                    {'title': 'Most Expensive Split', 'value': "0"},
                  ];

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: stats.length,
                      itemBuilder: (context, index) {
                        final stat = stats[index];
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                stat['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                stat['value']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (state is SplitError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('No splits available.'));
              }
            },
          ),
        ],
      ),
    );
  }
}
