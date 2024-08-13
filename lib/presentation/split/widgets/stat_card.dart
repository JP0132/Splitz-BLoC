import 'package:flutter/material.dart';

class StatCard extends StatefulWidget {
  final Map<String, dynamic> stat;
  const StatCard({
    super.key,
    required this.stat,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: widget.stat['color'],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(widget.stat['icon'], color: Colors.white, size: 24.0),
                const SizedBox(width: 6.0),
                Text(
                  widget.stat['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (widget.stat['value'] is List<String>)
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: (widget.stat['value'] as List<String>).map((tag) {
                  return Chip(
                    label: Text(
                      tag,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    backgroundColor: Colors.black26,
                  );
                }).toList(),
              )
            else
              Text(
                widget.stat['value']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
