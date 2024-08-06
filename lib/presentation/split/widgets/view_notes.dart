import 'package:flutter/material.dart';

class ViewNotes extends StatelessWidget {
  final String notes;
  const ViewNotes({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(notes),
      ),
    );
  }
}
