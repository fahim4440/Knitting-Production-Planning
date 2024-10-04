part of 'plannerpage_bloc.dart';

sealed class PlannerpageState extends Equatable {
  const PlannerpageState();
}

final class PlannerpageInitial extends PlannerpageState {
  @override
  List<Object> get props => [];
}

final class PlannerpageLoadingState extends PlannerpageState {
  @override
  List<Object?> get props => [];
}

final class PlannerpageLoadedState extends PlannerpageState {
  final List<Order> orders;
  final String selectedBuyer;
  final String currentFilter;
  const PlannerpageLoadedState({required this.orders, required this.selectedBuyer, required this.currentFilter});
  @override
  List<Object?> get props => [orders, selectedBuyer, currentFilter];
}

final class PlannerpageError extends PlannerpageState {
  final String error;
  const PlannerpageError(this.error);

  @override
  List<Object?> get props => [];
}

final class PlannerpageAssignOrderDialogState extends PlannerpageState {
  final List<Machine> machines;
  final List<OrderWiseRunningMachineModel> runningMachines;
  const PlannerpageAssignOrderDialogState(this.machines, this.runningMachines);

  @override
  List<Object?> get props => [machines, runningMachines];
}