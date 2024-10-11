part of 'floor_page_bloc.dart';

sealed class FloorPageEvent extends Equatable {
  const FloorPageEvent();
}

final class FloorPageFetchOrderByMachineEvent extends FloorPageEvent {
  final Floor floorName;

  const FloorPageFetchOrderByMachineEvent({required this.floorName});
  @override
  List<Object?> get props => [];
}