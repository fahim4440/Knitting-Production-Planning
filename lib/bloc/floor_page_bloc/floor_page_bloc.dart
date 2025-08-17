import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knitting_production_planning/database/machine_db_helper.dart';
import 'package:knitting_production_planning/database/order_db_helper.dart';
import 'package:knitting_production_planning/database/order_wise_running_machine_db_helper.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
import 'package:knitting_production_planning/model/order_model.dart';
import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';

part 'floor_page_event.dart';
part 'floor_page_state.dart';

class FloorPageBloc extends Bloc<FloorPageEvent, FloorPageState> {
  FloorPageBloc() : super(FloorPageInitial()) {
    on<FloorPageFetchOrderByMachineEvent>((event, emit) async {
      emit(FloorPageLoadingState());
      try {
        MachineDbHelper machineDbHelper = MachineDbHelper();
        List<Machine> machines = await machineDbHelper.getMachineByFloor(event.floorName);
        List<OrderWiseRunningMachineModel> runningMachinesOrder = [];
        OrderDbHelper orderDbHelper = OrderDbHelper();
        List<Order> orders = [];
        OrderWiseRunningMachineDbHelper orderWiseRunningMachineDbHelper = OrderWiseRunningMachineDbHelper();
        for(Machine machine in machines) {
          List<OrderWiseRunningMachineModel> runningOrder = await orderWiseRunningMachineDbHelper.getRunningOrdersOfMachine(machine.machineNumber);
          for(OrderWiseRunningMachineModel orderWiseRunningMachineModel in runningOrder) {
            Order? order = await orderDbHelper.getOrderByOrderId(orderWiseRunningMachineModel.orderId);
            if (order != null) {
              orders.add(order);
            }
          }
          runningMachinesOrder.addAll(runningOrder);
        }
        emit(FloorPageLoadedState(machines: machines, orderWiseRunningMachines: runningMachinesOrder, orders: orders));
      } catch (error) {
        emit(FloorPageErrorState(error.toString()));
      }
    });
  }
}
