// Firebsase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splitz_bloc/domain/usecases/favourite_split_usecase.dart';
import 'firebase_options.dart';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Pages
import 'package:splitz_bloc/presentation/navigation/bottom_nav_bar.dart';
import 'package:splitz_bloc/presentation/authentication/login_page.dart';
import 'package:splitz_bloc/presentation/authentication/sign_up_page.dart';
import 'package:splitz_bloc/presentation/onboarding/on_boarding_page.dart';
import 'package:splitz_bloc/presentation/splash/splash_page.dart';

// Bloc
import 'package:splitz_bloc/presentation/authentication/auth_bloc.dart';
import 'package:splitz_bloc/presentation/authentication/auth_event.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_bloc.dart';
import 'package:splitz_bloc/presentation/split/create_new_split.dart';
import 'package:splitz_bloc/presentation/split/expense_bloc.dart';
import 'package:splitz_bloc/presentation/split/split_bloc.dart';

// Usecases
import 'package:splitz_bloc/domain/usecases/get_current_user_usecase.dart';
import 'package:splitz_bloc/domain/usecases/google_sign_in_usecase.dart';
import 'package:splitz_bloc/domain/usecases/sign_up_usecase.dart';
import 'package:splitz_bloc/domain/usecases/add_expense_usecase.dart';
import 'package:splitz_bloc/domain/usecases/create_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/delete_expense_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_all_splits_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_expenses_for_split_usecase.dart';
import 'package:splitz_bloc/domain/usecases/edit_expense_usecase.dart';
import 'package:splitz_bloc/domain/usecases/get_split_by_id_usecase.dart';

// Repositories
import 'package:splitz_bloc/data/repositories/auth_repository_impl.dart';
import 'package:splitz_bloc/data/repositories/expense_repository_impl.dart';
import 'package:splitz_bloc/data/repositories/split_repository_impl.dart';

import 'package:splitz_bloc/utils/themes/theme.dart';

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
  final getSplitByIdUseCase = GetSplitByIdUsecase(splitRepository);
  final favouriteSplitUseCase = FavouriteSplitUsecase(splitRepository);

  // Expense Setup
  final expenseRepository = ExpenseRepositoryImpl(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);

  final addNewExpenseCase = AddExpenseUseCase(expenseRepository);
  final getExpensesforSplitUseCase =
      GetExpensesforSplitUseCase(expenseRepository);
  final deleteExpenseUseCase = DeleteExpenseUseCase(expenseRepository);
  final editExpenseUseCase = EditExpenseUsecase(expenseRepository);

  runApp(MainApp(
    signUpUseCase: signUpUseCase,
    googleSignInUseCase: googleSignInUseCase,
    getCurrentUserUseCase: getCurrentUserUseCase,
    createSplitUseCase: createSplitUseCase,
    getAllSplitsUseCase: getAllSplitsUseCase,
    addNewExpenseUseCase: addNewExpenseCase,
    getExpensesforSplitUseCase: getExpensesforSplitUseCase,
    deleteExpenseUseCase: deleteExpenseUseCase,
    editExpenseUseCase: editExpenseUseCase,
    getSplitByIdUseCase: getSplitByIdUseCase,
    favouriteSplitUseCase: favouriteSplitUseCase,
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
  final EditExpenseUsecase editExpenseUseCase;
  final GetSplitByIdUsecase getSplitByIdUseCase;
  final FavouriteSplitUsecase favouriteSplitUseCase;

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
    required this.editExpenseUseCase,
    required this.getSplitByIdUseCase,
    required this.favouriteSplitUseCase,
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
          create: (context) => SplitBloc(createSplitUseCase,
              getAllSplitsUseCase, getSplitByIdUseCase, favouriteSplitUseCase),
        ),
        BlocProvider(
            create: (context) => ExpenseBloc(
                  addNewExpenseUseCase,
                  getExpensesforSplitUseCase,
                  deleteExpenseUseCase,
                  editExpenseUseCase,
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
