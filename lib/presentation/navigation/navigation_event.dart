import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToHome extends NavigationEvent {}

class NavigateToOnboarding extends NavigationEvent {}

class NavigateToLogin extends NavigationEvent {}

class NavigateToAnalytics extends NavigationEvent {}

class NavigateToProfile extends NavigationEvent {}

class NavigateToSettings extends NavigationEvent {}
