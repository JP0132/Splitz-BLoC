import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/presentation/onboarding/on_boarding_cubit.dart';
import 'package:splitz_bloc/presentation/onboarding/widgets/w_onboarding.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(context),
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return PageView(
                  controller: state.pageController,
                  onPageChanged: (page) =>
                      context.read<OnboardingCubit>().pageChanged(page),
                  children: const [
                    WOnboarding(
                      image: CustomImages.collectingMoney,
                      title: "Keep track of your expenses",
                      subText:
                          "Welcome to SPLITZ, the place to split your expenses into different tags for easy organisation.",
                    ),
                    WOnboarding(
                      image: CustomImages.TrackExpensives,
                      title: "Breakdown your expenses",
                      subText:
                          "Filter through your expenses with tags, easily see the places you have spent on.",
                    ),
                    WOnboarding(
                      image: CustomImages.share,
                      title: "Share your splits with others!",
                      subText:
                          "Invite others to view and edit your splits, to easily manage your expenses together.",
                    ),
                  ],
                );
              },
            ),
            //Skip Button
            Positioned(
              top: Helperfunctions.getAppBarHeight(),
              right: 20,
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                return TextButton(
                  onPressed: () {
                    context.read<OnboardingCubit>().skipPage();
                  },
                  child: const Text("Skip"),
                );
              }),
            ),

            // Page indicators, dot form
            Positioned(
              bottom: kBottomNavigationBarHeight + 25.0,
              left: 20,
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return SmoothPageIndicator(
                    controller: state.pageController,
                    count: 3,
                    onDotClicked: (page) => context
                        .read<OnboardingCubit>()
                        .dotNavigationClick(page),
                    effect: ExpandingDotsEffect(
                      dotHeight: 6,
                    ),
                  );
                },
              ),
            ),

            // Next page button
            Positioned(
              right: 20,
              bottom: Helperfunctions.getBottomNavBarHeight(),
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () => context.read<OnboardingCubit>().nextPage(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const FaIcon(FontAwesomeIcons.arrowRight),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelperFunctions {
  static getBottomNavBarHeight() {}
}
