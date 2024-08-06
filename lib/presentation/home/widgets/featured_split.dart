import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/images.dart';

class FeaturedSplit extends StatefulWidget {
  final String totalSpent;
  final String dateCreated;
  final String listName;
  final Gradient colour;
  const FeaturedSplit({
    super.key,
    required this.totalSpent,
    required this.dateCreated,
    required this.listName,
    required this.colour,
  });

  @override
  State<FeaturedSplit> createState() => _FeaturedSplitState();
}

class _FeaturedSplitState extends State<FeaturedSplit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          width: 370,
          height: 190,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 6,
                color: Color(0x4B1A1F24),
                offset: Offset(
                  0.0,
                  2,
                ),
              )
            ],
            gradient: widget.colour,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  CustomImages.cardLogo,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Balance',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  widget.totalSpent,
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.listName,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        widget.dateCreated,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
