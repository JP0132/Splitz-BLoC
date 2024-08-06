import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:splitz_bloc/presentation/navigation/navigation_state.dart';
import 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeState()) {
    on<NavigateToHome>((event, emit) => emit(HomeState()));
    on<NavigateToAnalytics>((event, emit) => emit(AnalyticsState()));
    on<NavigateToProfile>((event, emit) => emit(ProfileState()));
    on<NavigateToSettings>((event, emit) => emit(SettingsState()));
  }
}
