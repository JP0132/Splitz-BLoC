import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class CustomCircularBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTapAction;
  final String btnText;

  const CustomCircularBtn({
    super.key,
    required this.icon,
    required this.onTapAction,
    required this.btnText,
  });

  @override
  State<CustomCircularBtn> createState() => _CustomCircularBtnState();
}

class _CustomCircularBtnState extends State<CustomCircularBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapAction,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: CustomColours.darkPrimary.withOpacity(0.3),
            child: Icon(
              widget.icon,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(widget.btnText),
        ],
      ),
    );
  }
}
