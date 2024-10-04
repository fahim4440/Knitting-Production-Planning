part of 'homepage_bloc.dart';

sealed class HomepageState extends Equatable {
  const HomepageState();
}

final class HomepageInitialState extends HomepageState {
  @override
  List<Object> get props => [];
}

final class HomepageLoadingState extends HomepageState {
  @override
  List<Object?> get props => [];
}

final class HomepageLoadedState extends HomepageState {
  final List<Order> orders;
  final String selectedBuyer;
  final String currentFilter;
  const HomepageLoadedState({required this.orders, required this.selectedBuyer, required this.currentFilter});
  @override
  List<Object?> get props => [orders, selectedBuyer, currentFilter];
}

final class HomePageError extends HomepageState {
  final String error;
  const HomePageError(this.error);

  @override
  List<Object?> get props => [];
}