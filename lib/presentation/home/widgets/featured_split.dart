import 'package:flutter/material.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class FeaturedSplit extends StatefulWidget {
  final SplitModel splitDetails;
  final double totalAmount;

  const FeaturedSplit({
    super.key,
    required this.splitDetails,
    required this.totalAmount,
  });

  @override
  State<FeaturedSplit> createState() => _FeaturedSplitState();
}

class _FeaturedSplitState extends State<FeaturedSplit> {
  @override
  Widget build(BuildContext context) {
    Gradient cardColour =
        Helperfunctions.getColourByName(widget.splitDetails.colour);
    return Padding(
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
          gradient: cardColour,
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
                "${Helperfunctions.getCurrencyFormat(widget.splitDetails.currency)}${widget.splitDetails.totalAmount}",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.splitDetails.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      Helperfunctions.getDateFormat(
                          widget.splitDetails.dateTime),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
