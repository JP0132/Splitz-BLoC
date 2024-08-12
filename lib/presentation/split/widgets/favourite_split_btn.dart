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

  @override
  void initState() {
    super.initState();
    final favBloc = context.read<FavouriteBloc>();
    favBloc.add(CheckFavouriteStatusRequested(widget.splitId, widget.userId));
  }

  // Future<void> _checkIfFavourited() async{
  //   final splitRepo = context.read<SplitRepository>();
  //   FavouriteModel favModel;

  //   final existingFav = await splitRepo.favouriteSplit(, widget.userId);

  // }

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
              context
                  .read<FavouriteBloc>()
                  .add(FavouriteSplitRequested(widget.splitId, widget.userId));
              // setState(() {
              //   if (_favourited) {
              //     _favourited = false;
              //   } else {
              //     _favourited = true;
              //   }
              // });
            },
            child: !_isFavourited
                ? Icon(
                    Icons.star_border,
                    size: 30,
                  )
                : Icon(
                    Icons.star,
                    size: 30,
                  ),
          ),
        );
      },
    );
  }
}
