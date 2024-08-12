import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/edit_split.dart';
import 'package:splitz_bloc/presentation/split/split.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class SplitCard extends StatelessWidget {
  final VoidCallback onCardTap;
  final List<SplitModel> splits; // Callback function

  const SplitCard({
    super.key,
    required this.splits,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: splits.length,
        itemBuilder: (context, index) {
          final split = splits[index];
          return Slidable(
            key: Key(split.id),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditSplit(
                          splitDetails: split,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  icon: FontAwesomeIcons.pencil,
                ),
                SlidableAction(
                  onPressed: (context) {
                    // context.read<SplitBloc>().add(DeleteSplitRequested(split));
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text('Expense deleted successfully!'),
                    //   backgroundColor: Colors.green,
                    // ));
                  },
                  backgroundColor: Colors.red,
                  icon: FontAwesomeIcons.trash,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplitPage(splitDetails: split),
                  ),
                );
                onCardTap(); // Call the callback when returning from SplitDetailPage
              },
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ListTile(
                  leading: Icon(Helperfunctions.getIconByName(split.category)),
                  title: Text(
                    split.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Total: \$${split.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  trailing: Text(
                    Helperfunctions.getDateFormat(split.dateTime),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
