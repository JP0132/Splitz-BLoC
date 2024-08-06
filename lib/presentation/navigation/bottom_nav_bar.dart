import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_bloc.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_event.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_state.dart';
import 'package:splitz_bloc/presentation/home/home_page.dart';
import 'package:splitz_bloc/utils/constants/colours.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/createSplit');
          },
          shape: CircleBorder(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              var selectedIndex = _getSelectedIndex(state);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      context.read<NavigationBloc>().add(NavigateToHome());
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.house,
                      color: selectedIndex == 0
                          ? CustomColours.darkPrimary
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<NavigationBloc>().add(NavigateToAnalytics());
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.chartLine,
                      color: selectedIndex == 1
                          ? CustomColours.darkPrimary
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<NavigationBloc>().add(NavigateToProfile());
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.user,
                      color: selectedIndex == 2
                          ? CustomColours.darkPrimary
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<NavigationBloc>().add(NavigateToSettings());
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.gear,
                      color: selectedIndex == 3
                          ? CustomColours.darkPrimary
                          : Colors.grey,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is HomeState) {
              return const HomePage();
            } else if (state is AnalyticsState) {
              return Container(color: Colors.blue);
            } else if (state is ProfileState) {
              return Container(color: Colors.orange);
            } else if (state is SettingsState) {
              return Container(color: Colors.indigo);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

int _getSelectedIndex(NavigationState state) {
  if (state is HomeState) {
    return 0;
  } else if (state is AnalyticsState) {
    return 1;
  } else if (state is ProfileState) {
    return 2;
  } else if (state is SettingsState) {
    return 3;
  } else {
    return 0;
  }
}
