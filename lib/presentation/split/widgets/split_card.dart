import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/edit_split.dart';
import 'package:splitz_bloc/presentation/split/split.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class SplitCard extends StatefulWidget {
  final VoidCallback onCardTap;
  final List<SplitModel> splits; // Callback function

  const SplitCard({
    super.key,
    required this.splits,
    required this.onCardTap,
  });

  @override
  State<SplitCard> createState() => _SplitCardState();
}

class _SplitCardState extends State<SplitCard> {
  SlidableController? currentOpen;
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.splits.length,
        itemBuilder: (context, index) {
          final split = widget.splits[index];
          return Slidable(
            key: Key(split.id),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                Builder(builder: (cont) {
                  if (currentOpen != null &&
                      currentOpen != Slidable.of(cont)!) {
                    if (_isOpen) {
                      currentOpen!.close();
                      _isOpen = false;
                    }
                  }
                  currentOpen = Slidable.of(cont)!;
                  _isOpen = true;
                  return ElevatedButton(
                      onPressed: () async {
                        Slidable.of(cont)!.close();
                        _isOpen = false;
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSplit(
                              splitDetails: split,
                            ),
                          ),
                        );
                        if (result == true) {
                          widget
                              .onCardTap(); // Refresh data if split was edited
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.all(10)),
                      child: const Icon(
                        FontAwesomeIcons.pencil,
                        color: Colors.white,
                        size: 25,
                      ));
                }),
                Builder(builder: (con) {
                  return ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Delete Split?"),
                                  content: const Text(
                                    "Are you sure you want to delete this split, this action is irreversible",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          context.read<SplitBloc>().add(
                                              DeleteSplitRequested(split.id));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Split deleted successfully!'),
                                            backgroundColor: Colors.green,
                                          ));
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "DELETE",
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                ));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(10)),
                      child: const Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.white,
                        size: 25,
                      ));
                }),
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
                widget
                    .onCardTap(); // Call the callback when returning from SplitDetailPage
              },
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      gradient: Helperfunctions.getColourByName(split.colour),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      child: Icon(
                          Helperfunctions.getIconByName(split.category) ??
                              Icons.error),
                    ),
                  ),
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
