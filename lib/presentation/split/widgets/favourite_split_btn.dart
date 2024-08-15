import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_state.dart';

class FavouriteSplitBtn extends StatefulWidget {
  final String splitId;
  final String userId;
  const FavouriteSplitBtn(
      {super.key, required this.splitId, required this.userId});

  @override
  State<FavouriteSplitBtn> createState() => _FavouriteSplitBtnState();
}

class _FavouriteSplitBtnState extends State<FavouriteSplitBtn> {
  bool _isFavourited = false;

  bool _favourited = false;

  @override
  void initState() {
    super.initState();
    final favBloc = context.read<FavouriteBloc>();
    favBloc.add(CheckFavouriteStatusRequested(widget.splitId, widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        if (state is FavouriteSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _isFavourited = state.isFavourited;
              });
            }
          });
        }

        return Padding(
          padding: const EdgeInsets.all(2),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFavourited = !_isFavourited;
              });
              context
                  .read<FavouriteBloc>()
                  .add(FavouriteSplitRequested(widget.splitId, widget.userId));
            },
            child: Icon(
              _isFavourited ? Icons.star : Icons.star_border,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
