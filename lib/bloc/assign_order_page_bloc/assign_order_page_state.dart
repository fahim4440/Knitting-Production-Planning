part of 'assign_order_page_bloc.dart';

sealed class AssignOrderPageState extends Equatable {
  const AssignOrderPageState();
}

final class AssignOrderPageInitial extends AssignOrderPageState {
  @override
  List<Object> get props => [];
}

final class AssignOrderPageLoading extends AssignOrderPageState {
  @override
  List<Object?> get props => [];
}

final class AssignOrderPageLoaded extends AssignOrderPageState {
  final List<Machine> machines;
  final List<OrderWiseRunningMachineModel> runningMachines;
  const AssignOrderPageLoaded({required this.machines, required this.runningMachines});

  @override
  List<Object?> get props => [machines, runningMachines];
}

final class AssignOrderPageError extends AssignOrderPageState {
  final String error;
  const AssignOrderPageError(this.error);
  @override
  List<Object?> get props => [error];
}