part of 'floor_page_bloc.dart';

sealed class FloorPageState extends Equatable {
  const FloorPageState();
}

final class FloorPageInitial extends FloorPageState {
  @override
  List<Object> get props => [];
}

final class FloorPageLoadingState extends FloorPageState {
  @override
  List<Object?> get props => [];
}

final class FloorPageLoadedState extends FloorPageState {
  final List<Machine> machines;
  final List<OrderWiseRunningMachineModel> orderWiseRunningMachines;
  final List<Order> orders;

  const FloorPageLoadedState({required this.machines, required this.orderWiseRunningMachines, required this.orders});
  @override
  List<Object?> get props => [machines, orderWiseRunningMachines, orders];
}

final class FloorPageErrorState extends FloorPageState {
  final String error;
  const FloorPageErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
