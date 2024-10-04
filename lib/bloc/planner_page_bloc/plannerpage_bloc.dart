import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knitting_production_planning/database/machine_db_helper.dart';
import 'package:knitting_production_planning/database/order_db_helper.dart';
import 'package:knitting_production_planning/database/order_wise_running_machine_db_helper.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';

import '../../model/order_model.dart';

part 'plannerpage_event.dart';
part 'plannerpage_state.dart';

class PlannerpageBloc extends Bloc<PlannerpageEvent, PlannerpageState> {
  PlannerpageBloc() : super(PlannerpageInitial()) {
    on<FetchOrdersPlannerpageEvent>((event, emit) async {
      emit(PlannerpageLoadingState());
      try {
        List<Order> orders = await _fetchAllOrder();
        emit(PlannerpageLoadedState(orders: orders, selectedBuyer: "", currentFilter: 'All',));
      } catch (e) {
        emit(PlannerpageError(e.toString()));
      }
    });

    // Handle SelectBuyer event
    on<SelectBuyerPlannerpageEvent>((event, emit) async {
      emit(PlannerpageLoadingState());
      try {
        OrderDbHelper dbHelper = OrderDbHelper();
        List<Order>? orders = await dbHelper.getOrdersByBuyerName(event.buyerName);
        if (orders != null) {
          if (orders.isNotEmpty) {
            orders.sort((a, b) => b.id!.compareTo(int.parse(a.id.toString())));
          }
          emit(PlannerpageLoadedState(orders: orders, selectedBuyer: event.buyerName, currentFilter: 'All',));
        } else {
          orders = [];
          emit(PlannerpageLoadedState(orders: orders, selectedBuyer: event.buyerName, currentFilter: 'All',));
        }
      } catch (e) {
        emit(PlannerpageError(e.toString()));
      }
    });

    // Handle FilterOrders event
    on<FilterOrdersPlannerpageEvent>((event, emit) async {
      if (state is PlannerpageLoadedState) {
        PlannerpageLoadedState loadedState = state as PlannerpageLoadedState;
        List<Order> filteredOrders = await _filterOrders(
          loadedState.orders,
          event.filter,
        );
        if (filteredOrders.isNotEmpty) {
          filteredOrders.sort((a, b) => b.id!.compareTo(int.parse(a.id.toString())));
        }
        emit(PlannerpageLoadedState(orders: filteredOrders, selectedBuyer: loadedState.selectedBuyer, currentFilter: event.filter,));
      }
    });
  }

  Future<List<Order>> _filterOrders(List<Order> orders, String filter) async {
    if (filter == 'All') {
      if (orders.isEmpty) {
        orders = await _fetchAllOrder();
      }
      return orders;
    }
    return orders.where((order) => order.status.toString().split(".").last == filter).toList();
  }

  Future<List<Order>> _fetchAllOrder() async {
    OrderDbHelper dbHelper = OrderDbHelper();
    List<Order> allOrders = await dbHelper.getAllOrders();
    List<Order> orders = [];
    if(allOrders.isNotEmpty) {
      orders.addAll(allOrders);
    }
    if (orders.isNotEmpty) {
      orders.sort((a, b) => b.id!.compareTo(int.parse(a.id.toString())));
    }
    return orders;
  }
}
