import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitz_bloc/pages/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:splitz_bloc/pages/authentication/domain/usecases/google_sign_in_usecase.dart';
import 'package:splitz_bloc/pages/authentication/domain/usecases/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SignUpUseCase signUpUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc(
      this.signUpUseCase, this.googleSignInUseCase, this.getCurrentUserUseCase)
      : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<GetCurrentUserRequested>(_onGetCurrentUserRequested);
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(
          event.email, event.password, event.firstName, event.surname);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onGoogleSignInRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await googleSignInUseCase();
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthAuthenticated());
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }

  Future<void> _onGetCurrentUserRequested(
      GetCurrentUserRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await getCurrentUserUseCase();
      emit(AuthUserLoaded(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
