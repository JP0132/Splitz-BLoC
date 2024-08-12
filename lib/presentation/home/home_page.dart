import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/entities/user.dart';
import 'package:splitz_bloc/presentation/authentication/bloc/auth_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/bloc/auth_state.dart';
import 'package:splitz_bloc/presentation/home/widgets/custom_circular_container.dart';
import 'package:splitz_bloc/presentation/home/widgets/custom_circular_background.dart';
import 'package:splitz_bloc/presentation/home/widgets/featured_split.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_state.dart';
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
  User? _user;

  @override
  void initState() {
    super.initState();
    context.read<SplitBloc>().add(FetchAllSplitRequested());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Helperfunctions.isDarkMode(context);

    SplitModel newCardData = SplitModel(
      id: "1",
      userId: "2",
      totalAmount: 7454.0,
      dateTime: DateTime.now(),
      name: "Portugal Holiday",
      colour: 'Red',
      category: 'Holiday',
      currency: "EUR",
    );

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
            _user = state.user;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {});
            });
            if (_user != null) {
              String firstInitial = _user!.firstName[0];
              String lastInitial = _user!.surname[0];
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
              return const Center(child: Text('No user signed in'));
            }
          } else {
            return const Center(child: Text('N/A'));
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Text(
                        'WELCOME BACK ${_user?.firstName.toUpperCase() ?? "FIRSTNAME"}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
                          splitDetails: newCardData,
                          totalAmount: 0,
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
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SplitsLoaded) {
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
