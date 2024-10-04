import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knitting_production_planning/database/order_db_helper.dart';

import '../../model/order_model.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitialState()) {
    on<FetchOrdersEvent>((event, emit) async {
      emit(HomepageLoadingState());
      try {
        List<Order> orders = await fetchAllOrderOfTeamLeader();
        emit(HomepageLoadedState(orders: orders, selectedBuyer: "", currentFilter: 'All',));
      } catch (e) {
        emit(HomePageError(e.toString()));
      }

    });

    // Handle SelectBuyer event
    on<SelectBuyerEvent>((event, emit) async {
      emit(HomepageLoadingState());
      try {
        OrderDbHelper dbHelper = OrderDbHelper();
        List<Order>? orders = await dbHelper.getOrdersByBuyerName(event.buyerName);
        if (orders != null) {
          if (orders.isNotEmpty) {
            orders.sort((a, b) => b.id!.compareTo(int.parse(a.id.toString())));
          }
          emit(HomepageLoadedState(orders: orders, selectedBuyer: event.buyerName, currentFilter: 'All',));
        } else {
          orders = [];
          emit(HomepageLoadedState(orders: orders, selectedBuyer: event.buyerName, currentFilter: 'All',));
        }
      } catch (e) {
        emit(HomePageError(e.toString()));
      }
    });

    // Handle FilterOrders event
    on<FilterOrdersEvent>((event, emit) async {
      if (state is HomepageLoadedState) {
        HomepageLoadedState loadedState = state as HomepageLoadedState;
        List<Order> filteredOrders = await _filterOrders(
          loadedState.orders,
          event.filter,
        );
        if (filteredOrders.isNotEmpty) {
          filteredOrders.sort((a, b) => b.id!.compareTo(int.parse(a.id.toString())));
        }
        emit(HomepageLoadedState(orders: filteredOrders, selectedBuyer: loadedState.selectedBuyer, currentFilter: event.filter,
        ));
      }
    });

    on<AddNewOrderEvent>((event, emit) async {
      try {
        OrderDbHelper dbHelper = OrderDbHelper();
        await dbHelper.createOrder(event.order);
        List<Order> orders = await fetchAllOrderOfTeamLeader();
        emit(HomepageLoadedState(orders: orders, selectedBuyer: "", currentFilter: 'All',));
      } catch(error) {
        emit(HomePageError(error.toString()));
      }
    });
  }

  Future<List<Order>> _filterOrders(List<Order> orders, String filter) async {
    if (filter == 'All') {
      if (orders.isEmpty) {
        orders = await fetchAllOrderOfTeamLeader();
      }
      return orders;
    }
    return orders.where((order) => order.status.toString().split(".").last == filter).toList();
  }

  Future<List<Order>> fetchAllOrderOfTeamLeader() async {
    OrderDbHelper dbHelper = OrderDbHelper();
    final List<Order>? ordersOfMnS = await dbHelper.getOrdersByBuyerName("M&S");
    final List<Order>? ordersOfRnd = await dbHelper.getOrdersByBuyerName("R&D");
    final List<Order>? ordersOfExpress = await dbHelper.getOrdersByBuyerName("Express");
    final List<Order>? ordersOfNext = await dbHelper.getOrdersByBuyerName("Next");
    final List<Order>? ordersOfTommy = await dbHelper.getOrdersByBuyerName("Tommy Hillfiger");
    List<Order> orders = [];
    if(ordersOfMnS != null) {
      orders.addAll(ordersOfMnS);
    }
    if(ordersOfRnd != null) {
      orders.addAll(ordersOfRnd);
    }
    if(ordersOfExpress != null) {
      orders.addAll(ordersOfExpress);
    }
    if(ordersOfTommy != null) {
      orders.addAll(ordersOfTommy);
    }
    if(ordersOfNext != null) {
      orders.addAll(ordersOfNext);
    }
    if (orders.isNotEmpty) {
      orders.sort((a, b) => b.id!.compareTo(int.parse(a.id.toString())));
    }
    return orders;
  }
}
