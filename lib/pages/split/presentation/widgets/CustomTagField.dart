import 'package:flutter/material.dart';

class CustomTagField extends StatefulWidget {
  final Function(List<String>) onTagsChanged;
  final List<String> addedTags;
  const CustomTagField(
      {super.key, required this.onTagsChanged, this.addedTags = const []});

  @override
  State<CustomTagField> createState() => _CustomTagFieldState();
}

class _CustomTagFieldState extends State<CustomTagField> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    // Initialize _tags with the provided addedTags
    _tags = List.from(widget.addedTags);
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      setState(() {
        _tags.add(tag);
        widget.onTagsChanged(_tags);
      });
      _controller.clear();
      // print('Tag added: $tag'); // Debug statement
      // print('Current tags: $_tags'); // Debug statement
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
      widget.onTagsChanged(_tags);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Add a tag',
            border: OutlineInputBorder(),
          ),
          onSubmitted: _addTag,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _tags
              .map((tag) => Chip(
                    label: Text(tag),
                    deleteIcon: Icon(Icons.clear),
                    onDeleted: () => _removeTag(tag),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
