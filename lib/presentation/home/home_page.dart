import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/data/models/expense_model.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/entities/user.dart';
import 'package:splitz_bloc/models/featured_card_data.dart';
import 'package:splitz_bloc/presentation/authentication/bloc/auth_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/bloc/auth_state.dart';
import 'package:splitz_bloc/presentation/home/widgets/custom_circular_btn.dart';
import 'package:splitz_bloc/presentation/home/widgets/custom_circular_container.dart';
import 'package:splitz_bloc/presentation/home/widgets/custom_circular_background.dart';
import 'package:splitz_bloc/presentation/home/widgets/favourite_placeholder.dart';
import 'package:splitz_bloc/presentation/home/widgets/featured_split.dart';
import 'package:splitz_bloc/presentation/home/widgets/home_featured_card.dart';
import 'package:splitz_bloc/presentation/split/add_new_expense.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/expense_state.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/favourite_state.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_bloc.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_event.dart';
import 'package:splitz_bloc/presentation/split/bloc/split_state.dart';
import 'package:splitz_bloc/presentation/split/split.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';
import 'package:splitz_bloc/widgets/circular_iconbtn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  SplitModel? _favouritedSplit;

  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouritedSplitRequest());
    context.read<SplitBloc>().add(FetchAllSplitRequested());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addExpenseAction(SplitModel? fav) async {
    if (_favouritedSplit != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewExpense(splitDetails: fav!),
        ),
      );

      if (result) {
        context.read<FavouriteBloc>().add(FetchFavouritedSplitRequest());
        context.read<SplitBloc>().add(FetchAllSplitRequested());
      }
    }
  }

  void _viewFavouriteDetailsAction(SplitModel? fav) async {
    if (_favouritedSplit != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplitPage(splitDetails: fav!),
        ),
      );

      if (result) {
        context.read<FavouriteBloc>().add(FetchFavouritedSplitRequest());
        context.read<SplitBloc>().add(FetchAllSplitRequested());
      }
    }
  }

  // Filters through the splits to get the last three splits created
  List<FeaturedCardData> _lastThreeSplits(List<SplitModel> splits) {
    List<SplitModel> sortedSplits = splits
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    List<SplitModel> lastThreeCreated = sortedSplits.take(3).toList();

    List<FeaturedCardData> data = [];

    for (var split in lastThreeCreated) {
      FeaturedCardData newData = FeaturedCardData(
        dateCreated: split.dateTime,
        value: split.totalAmount,
        name: split.name,
        icon: split.category,
        colour: split.colour,
      );

      data.add(newData);
    }

    return data;
  }

  // Filters through the expenses to get the last three expenses added
  List<FeaturedCardData> _lastThreeExpensesAdded(List<ExpenseModel> expenses) {
    List<ExpenseModel> sortedExpenses = expenses
      ..sort((a, b) => b.dateTimeAdded.compareTo(a.dateTimeAdded));

    List<ExpenseModel> lastThreeAdded = sortedExpenses.take(3).toList();

    List<FeaturedCardData> data = [];

    for (var split in lastThreeAdded) {
      FeaturedCardData newData = FeaturedCardData(
        dateCreated: split.dateTimeAdded,
        value: split.paid,
        name: split.name,
      );
      data.add(newData);
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Helperfunctions.isDarkMode(context);

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
      body: Column(
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
                    _buildFeaturedSplitSection(),
                    Positioned(
                      top: 300,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomCircularBtn(
                            icon: FontAwesomeIcons.plus,
                            onTapAction: () =>
                                _addExpenseAction(_favouritedSplit),
                            btnText: "Add Expense",
                          ),
                          CircularIconbtn(
                            text: "Exchange",
                            icon: FontAwesomeIcons.moneyBill,
                            onPressed: () {},
                          ),
                          CustomCircularBtn(
                            icon: FontAwesomeIcons.info,
                            onTapAction: () =>
                                _viewFavouriteDetailsAction(_favouritedSplit),
                            btnText: "Details",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 85),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<SplitBloc, SplitState>(
                    builder: (context, state) {
                      return _buildHomeContent(state);
                    },
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFeaturedSplitSection() {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavouriteLoaded) {
          _favouritedSplit = state.favouriteSplit;
          if (_favouritedSplit == null) {
            return const Padding(
              padding: EdgeInsets.only(top: 100.0, right: 8, left: 8),
              child: FavouritePlaceholder(),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 100.0, right: 8, left: 8),
            child: FeaturedSplit(
              splitDetails: _favouritedSplit!,
              totalAmount: 0,
            ),
          );
        } else if (state is FavouriteFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }

  Widget _buildHomeContent(SplitState state) {
    if (state is SplitLoading) {
      return Center(
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 4),
          builder: (context, value, _) => SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: value,
              backgroundColor: Colors.grey,
              strokeWidth: 4,
            ),
          ),
        ),
      );
    } else if (state is SplitsLoaded) {
      if (state.splits.isEmpty) {
        return const Center(child: Text("No Splits have been created"));
      }

      final expenseBloc = context.read<ExpenseBloc>();
      expenseBloc.add(FetchAllUsersExpensesRequested());

      return BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, expenseState) {
        if (expenseState is ExpenseLoading) {
          return const CircularProgressIndicator();
        } else if (expenseState is ExpensesLoaded) {
          final expenses = expenseState.expenses;
          if (expenses.isEmpty) {
            return HomeFeaturedCard(
              dataList: _lastThreeSplits(state.splits),
              text: "Latest Splits",
            );
          }

          return Column(
            children: [
              HomeFeaturedCard(
                dataList: _lastThreeSplits(state.splits),
                text: "Latest Splits",
              ),
              HomeFeaturedCard(
                dataList: _lastThreeExpensesAdded(expenses),
                text: "Latest Expense Added",
              ),
            ],
          );
        } else if (expenseState is ExpenseError) {
          return Center(child: Text('Error: ${expenseState.message}'));
        } else {
          return const Center(child: Text('No expenses available.'));
        }
      });
    } else if (state is SplitError) {
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return const Center(child: Text('No splits available.'));
    }
  }
}
