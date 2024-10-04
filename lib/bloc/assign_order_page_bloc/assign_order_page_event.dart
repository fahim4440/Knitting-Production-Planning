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