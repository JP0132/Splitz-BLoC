import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:splitz_bloc/presentation/authentication/auth_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/auth_event.dart';
import 'package:splitz_bloc/presentation/authentication/auth_state.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_button.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_divider.dart';
import 'package:splitz_bloc/presentation/authentication/widgets/auth_field.dart';
import 'package:splitz_bloc/utils/constants/images.dart';
import 'package:splitz_bloc/utils/helper/helper_functions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Helperfunctions.isDarkMode(context);

    void createNewUser(BuildContext context) {
      final email = emailController.text;
      final password = passwordController.text;
      final firstName = firstNameController.text;
      final surname = surnameController.text;

      context
          .read<AuthBloc>()
          .add(SignUpRequested(email, password, firstName, surname));
    }

    void navigateToLoginIntoAccount(BuildContext context) {
      Navigator.pushNamed(context, '/login');
    }

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 24.0, bottom: 24.0, right: 24.0),
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
                    const SizedBox(height: 10.0),
                    Text("Let's create your account",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AuthField(
                                    hintText: "First Name",
                                    controller: firstNameController),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: AuthField(
                                  hintText: "Surname",
                                  controller: surnameController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthField(
                            hintText: "Enter Email",
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthField(
                            hintText: "Create Password",
                            controller: passwordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthField(
                            hintText: "Confirm Password",
                            controller: confirmPasswordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                            if (state is AuthLoading) {
                              return CircularProgressIndicator();
                            }
                            return AuthButton(
                              text: "Create Account",
                              operation: () => createNewUser(context),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthButton(
                            text: "Login",
                            operation: () =>
                                navigateToLoginIntoAccount(context),
                            borderColor: Colors.white,
                            gradient: LinearGradient(colors: [
                              Colors.transparent,
                              Colors.transparent
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthDivider(
                              isDark: isDark, divderText: "Or Sign Up With"),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () => context
                                  .read<AuthBloc>()
                                  .add(GoogleSignInRequested()),
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
      ),
    );
  }
}
