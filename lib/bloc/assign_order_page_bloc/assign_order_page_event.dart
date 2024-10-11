part of 'assign_order_page_bloc.dart';

sealed class AssignOrderPageEvent extends Equatable {
  const AssignOrderPageEvent();
}

final class FetchMachinesByTypeEvent extends AssignOrderPageEvent {
  final MachineType machineType;

  const FetchMachinesByTypeEvent({required this.machineType});

  @override
  List<Object?> get props => [machineType];
}

final class AssignOrderToMachineEvent extends AssignOrderPageEvent {
  final int perDayProduction;
  final int quantity;
  final String machineNumber;
  final int orderId;
  final MachineType machineType;

  const AssignOrderToMachineEvent({required this.perDayProduction, required this.quantity, required this.machineNumber, required this.orderId, required this.machineType});

  @override
  List<Object?> get props => [perDayProduction, quantity, machineNumber];
}