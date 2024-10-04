part of 'homepage_bloc.dart';

sealed class HomepageEvent extends Equatable {
  const HomepageEvent();
}

final class FetchOrdersEvent extends HomepageEvent {
  const FetchOrdersEvent();

  @override
  List<Object?> get props => [];
}

final class SelectBuyerEvent extends HomepageEvent {
  final String buyerName;
  const SelectBuyerEvent(this.buyerName);

  @override
  List<Object?> get props => [buyerName];
}

class FilterOrdersEvent extends HomepageEvent {
  final String filter;
  const FilterOrdersEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class AddNewOrderEvent extends HomepageEvent {
  final Order order;
  const AddNewOrderEvent(this.order);

  @override
  List<Object?> get props => [order];
}