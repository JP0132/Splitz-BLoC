import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/models/split_details.dart';
import 'package:splitz_bloc/presentation/authentication/auth_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/auth_state.dart';
import 'package:splitz_bloc/presentation/home/widgets/CustomCircularContainer.dart';
import 'package:splitz_bloc/presentation/home/widgets/CustomCurvedBackground.dart';
import 'package:splitz_bloc/presentation/home/widgets/featured_split.dart';
import 'package:splitz_bloc/presentation/split/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/split_event.dart';
import 'package:splitz_bloc/presentation/split/split_state.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';
import 'package:splitz_bloc/widgets/circular_iconbtn.dart';
import 'package:splitz_bloc/presentation/home/widgets/expanded_box_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Helperfunctions.isDarkMode(context);
    context.read<SplitBloc>().add(FetchAllSplitRequested());

    SplitDetails newCardData = SplitDetails(
      totalAmount: 7454.0,
      createdAt: DateTime.now(),
      name: "Portugal Holiday",
      colour: 'red',
      category: 'Holiday',
    );

    String formattedDate = Helperfunctions.getDateFormat(newCardData.createdAt);
    String formattedAmount = "\$${newCardData.totalAmount.toString()}";

    List<SplitDetails> cardItemsData = [
      SplitDetails(
        totalAmount: 5654.0,
        createdAt: DateTime.now(),
        name: "Holiday 1",
        colour: 'red',
        category: 'Holiday',
      ),
      SplitDetails(
        totalAmount: 464.0,
        createdAt: DateTime.now(),
        name: "Shopping Trip 2",
        colour: 'red',
        category: 'Holiday',
      ),
      SplitDetails(
        totalAmount: 464.0,
        createdAt: DateTime.now(),
        name: "Shopping Trip 2",
        colour: 'red',
        category: 'Holiday',
      ),
      SplitDetails(
        totalAmount: 464.0,
        createdAt: DateTime.now(),
        name: "Shopping Trip 2",
        colour: 'red',
        category: 'Holiday',
      ),
      SplitDetails(
        totalAmount: 464.0,
        createdAt: DateTime.now(),
        name: "Shopping Trip 2",
        colour: 'red',
        category: 'Holiday',
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthLoading) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AuthUserLoaded) {
            final user = state.user;
            if (user != null) {
              String firstInitial = user.firstName[0];
              String lastInitial = user.surname[0];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '$firstInitial$lastInitial',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
              );
            } else {
              return Center(child: Text('No user signed in'));
            }
          } else {
            return Center(child: Text('N/A'));
          }
        }),
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedBackground(),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: CustomColours.darkPrimaryVariant,
                child: SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -150,
                        right: -250,
                        child: CustomCircularContainer(
                          backgroundColour:
                              CustomColours.darkOnSurface.withOpacity(0.1),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: 250,
                        child: CustomCircularContainer(
                          backgroundColour:
                              CustomColours.darkOnSurface.withOpacity(0.1),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: -300,
                        child: CustomCircularContainer(
                          backgroundColour:
                              CustomColours.darkOnSurface.withOpacity(0.1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 100.0, right: 8, left: 8),
                        child: FeaturedSplit(
                          totalSpent: formattedAmount,
                          dateCreated: formattedDate,
                          listName: newCardData.name,
                          colour: CustomColours.purpleGradient,
                        ),
                      ),
                      Positioned(
                        top: 300,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CircularIconbtn(
                              text: "Add Money",
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {},
                            ),
                            CircularIconbtn(
                              text: "Exchange",
                              icon: FontAwesomeIcons.moneyBill,
                              onPressed: () {},
                            ),
                            CircularIconbtn(
                              text: "Details",
                              icon: FontAwesomeIcons.circleInfo,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<SplitBloc, SplitState>(
              builder: (context, state) {
                if (state is SplitLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SplitLoaded) {
                  final splits = state.splits;
                  if (splits.isEmpty) {
                    return const Center(child: Text('No splits available.'));
                  } else {
                    return ExpandedBoxList(splits: splits);
                  }
                } else if (state is SplitError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No splits available.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
