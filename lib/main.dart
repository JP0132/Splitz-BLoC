import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splitz_bloc/navigation/bottom_nav_bar.dart';
import 'package:splitz_bloc/navigation/navigation_bloc.dart';
import 'package:splitz_bloc/pages/authentication/data/repositories/auth_repository_impl.dart';
import 'package:splitz_bloc/pages/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:splitz_bloc/pages/authentication/domain/usecases/google_sign_in_usecase.dart';
import 'package:splitz_bloc/pages/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:splitz_bloc/pages/authentication/presentation/auth_bloc.dart';
import 'package:splitz_bloc/pages/authentication/presentation/auth_event.dart';
import 'package:splitz_bloc/pages/authentication/presentation/login_page.dart';
import 'package:splitz_bloc/pages/authentication/presentation/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splitz_bloc/pages/onboarding/on_boarding_page.dart';
import 'package:splitz_bloc/pages/splash/splash_page.dart';
import 'package:splitz_bloc/pages/split/data/repositories/expense_repository.dart';
import 'package:splitz_bloc/pages/split/data/repositories/split_repository_impl.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/AddExpenseUseCase.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/CreateSplitUseCase.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/DeleteExpenseUseCase.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/GetAllSplitsUseCase.dart';
import 'package:splitz_bloc/pages/split/domain/usecases/GetExpensesForSplitUseCase.dart';
import 'package:splitz_bloc/pages/split/presentation/create_new_split.dart';
import 'package:splitz_bloc/pages/split/presentation/expense_bloc.dart';
import 'package:splitz_bloc/pages/split/presentation/split_bloc.dart';
import 'package:splitz_bloc/utils/themes/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Authentication setup
  final authRepository = AuthRepositoryImpl(
      FirebaseAuth.instance, FirebaseFirestore.instance, GoogleSignIn());

  final signUpUseCase = SignUpUseCase(authRepository);
  final googleSignInUseCase = GoogleSignInUseCase(authRepository);
  final getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);

  // Split setup
  final splitRepository = SplitRepositoryImpl(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);

  final createSplitUseCase = CreateSplitUseCase(splitRepository);
  final getAllSplitsUseCase = GetAllSplitsUseCase(splitRepository);

  // Expense Setup
  final expenseRepository = ExpenseRepositoryImpl(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);

  final addNewExpenseCase = AddExpenseUseCase(expenseRepository);
  final getExpensesforSplitUseCase =
      GetExpensesforSplitUseCase(expenseRepository);
  final deleteExpenseUseCase = DeleteExpenseUseCase(expenseRepository);

  runApp(MainApp(
    signUpUseCase: signUpUseCase,
    googleSignInUseCase: googleSignInUseCase,
    getCurrentUserUseCase: getCurrentUserUseCase,
    createSplitUseCase: createSplitUseCase,
    getAllSplitsUseCase: getAllSplitsUseCase,
    addNewExpenseUseCase: addNewExpenseCase,
    getExpensesforSplitUseCase: getExpensesforSplitUseCase,
    deleteExpenseUseCase: deleteExpenseUseCase,
  ));
}

class MainApp extends StatelessWidget {
  final SignUpUseCase signUpUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CreateSplitUseCase createSplitUseCase;
  final GetAllSplitsUseCase getAllSplitsUseCase;
  final AddExpenseUseCase addNewExpenseUseCase;
  final GetExpensesforSplitUseCase getExpensesforSplitUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  const MainApp({
    super.key,
    required this.signUpUseCase,
    required this.googleSignInUseCase,
    required this.getCurrentUserUseCase,
    required this.createSplitUseCase,
    required this.getAllSplitsUseCase,
    required this.addNewExpenseUseCase,
    required this.getExpensesforSplitUseCase,
    required this.deleteExpenseUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            signUpUseCase,
            googleSignInUseCase,
            getCurrentUserUseCase,
          )
            ..add(AppStarted())
            ..add(GetCurrentUserRequested()),
        ),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(
          create: (context) =>
              SplitBloc(createSplitUseCase, getAllSplitsUseCase),
        ),
        BlocProvider(
            create: (context) => ExpenseBloc(
                  addNewExpenseUseCase,
                  getExpensesforSplitUseCase,
                  deleteExpenseUseCase,
                ))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: CustomAppTheme.lightTheme,
        darkTheme: CustomAppTheme.darkTheme,
        routes: {
          '/splash': (context) => SplashPage(),
          '/home': (context) => CustomBottomNavbar(),
          '/onboarding': (context) => OnboardingPage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/createSplit': (context) => CreateNewSplit(),
        },
        home: SplashPage(),
      ),
    );
  }
}
