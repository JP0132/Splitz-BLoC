import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class HomeState extends NavigationState {}

class SplitNavState extends NavigationState {}

class AnalyticsState extends NavigationState {}

class ProfileState extends NavigationState {}

class SettingsState extends NavigationState {}
