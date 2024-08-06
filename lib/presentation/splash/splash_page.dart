import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_bloc.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_event.dart';
import 'package:splitz_bloc/presentation/authentication/auth_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/auth_state.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _bounceAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.bounceOut),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, navigate based on authentication state
        _navigateBasedOnAuthState();
      }
    });
  }

  void _navigateBasedOnAuthState() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.stream.listen((state) {
      if (state is AuthAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
        // context.read<NavigationBloc>().add(NavigateToHome());
      } else if (state is AuthUnauthenticated) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Helperfunctions.isDarkMode(context);
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _bounceAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: 100,
                  width: 250,
                  image: isDark
                      ? const AssetImage(CustomImages.darkThemeLogo)
                      : const AssetImage(CustomImages.lightThemeLogo),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Splitz',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
