part of 'plannerpage_bloc.dart';

sealed class PlannerpageEvent extends Equatable {
  const PlannerpageEvent();
}

final class FetchOrdersPlannerpageEvent extends PlannerpageEvent {
  const FetchOrdersPlannerpageEvent();

  @override
  List<Object?> get props => [];
}

final class SelectBuyerPlannerpageEvent extends PlannerpageEvent {
  final String buyerName;
  const SelectBuyerPlannerpageEvent(this.buyerName);

  @override
  List<Object?> get props => [buyerName];
}

class FilterOrdersPlannerpageEvent extends PlannerpageEvent {
  final String filter;
  const FilterOrdersPlannerpageEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

// class AddNewOrderEvent extends PlannerpageEvent {
//   final Order order;
//   const AddNewOrderEvent(this.order);
//
//   @override
//   List<Object?> get props => [order];
// }