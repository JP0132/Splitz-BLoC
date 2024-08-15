import 'package:flutter/material.dart';
import 'package:splitz_bloc/utils/constants/images.dart';

class FavouritePlaceholder extends StatefulWidget {
  const FavouritePlaceholder({super.key});

  @override
  State<FavouritePlaceholder> createState() => _FavouritePlaceholderState();
}

class _FavouritePlaceholderState extends State<FavouritePlaceholder> {
  @override
  Widget build(BuildContext context) {
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
          gradient: LinearGradient(colors: [Colors.grey, Colors.grey.shade300]),
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
                'NO FAVOURITE',
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "NO FAVOURITED SPLIT! FAVOURITE A SPLIT TO VIEW HERE",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
