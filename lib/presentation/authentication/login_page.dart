import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/presentation/navigation/bloc/navigation_event.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_button.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_divider.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_field.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    void navigateToCreateAccount(BuildContext context) {
      Navigator.pushNamed(context, '/signup');
    }

    final isDark = Helperfunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 56.0, left: 24.0, bottom: 24.0, right: 24.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 100,
                    width: 250,
                    image: AssetImage(isDark
                        ? CustomImages.darkThemeLogo
                        : CustomImages.lightThemeLogo),
                  ),
                  const SizedBox(height: 16.0),
                  Text("Welcome back to SPLITZ",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16.0),
                ],
              ),
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  children: [
                    AuthField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthButton(
                      text: "Sign In",
                      operation: () => navigateToCreateAccount(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      text: "Create Account",
                      borderColor: Colors.white,
                      operation: () => navigateToCreateAccount(context),
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.transparent]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthDivider(isDark: isDark, divderText: "Or Sign In With"),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(395, 55),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                        ),
                        label: const Text(
                          "Google",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
