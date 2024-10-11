import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knitting_production_planning/database/order_db_helper.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
import 'package:knitting_production_planning/model/order_model.dart';
import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';

import '../../database/machine_db_helper.dart';
import '../../database/order_wise_running_machine_db_helper.dart';

part 'assign_order_page_event.dart';
part 'assign_order_page_state.dart';

class AssignOrderPageBloc extends Bloc<AssignOrderPageEvent, AssignOrderPageState> {
  AssignOrderPageBloc() : super(AssignOrderPageInitial()) {
    on<FetchMachinesByTypeEvent>((event, emit) async {
      emit(AssignOrderPageLoading());
      try {
        MachineDbHelper machineDbHelper = MachineDbHelper();
        OrderWiseRunningMachineDbHelper runningMachineDbHelper = OrderWiseRunningMachineDbHelper();
        List<Machine> machines = await machineDbHelper.getMachineByMachineType(event.machineType);
        List<OrderWiseRunningMachineModel> runningOrders = [];
        for (Machine machine in machines) {
          List<OrderWiseRunningMachineModel> orders = await runningMachineDbHelper.getRunningOrdersOfMachine(machine.machineNumber);
          runningOrders.addAll(orders);  // Add the orders to the runningOrders list
        }
        emit(AssignOrderPageLoaded(machines: machines, runningMachines: runningOrders));
      } catch(error) {
        emit(AssignOrderPageError(error.toString()));
      }
    });

    on<AssignOrderToMachineEvent>((event, emit) async {
      emit(AssignOrderPageLoading());
      try {
        double neededDay = event.quantity / event.perDayProduction;
        print("Datetime: ${DateTime.now().add(Duration(days: neededDay.toInt()))}");
        OrderWiseRunningMachineModel runningMachineModel = OrderWiseRunningMachineModel(orderId: event.orderId, machineNumber: event.machineNumber, quantity: event.quantity, balance: event.quantity, perDayProduction: event.perDayProduction, averagePerDayProduction: 0, roll: 0, estimatedTimeToKnit: DateTime.now().add(Duration(days: neededDay.toInt())),);
        // runningMachineModel.estimatedTimeToKnit = DateTime.now().add(Duration(days: neededDay.toInt()));
        OrderWiseRunningMachineDbHelper dbHelper = OrderWiseRunningMachineDbHelper();
        OrderDbHelper orderDbHelper = OrderDbHelper();
        await dbHelper.insertRunningMachine(runningMachineModel);
        Order? order = await orderDbHelper.getOrderByOrderId(event.orderId);
        List<OrderWiseRunningMachineModel> runningMachinesInOrder = [];
        if (order != null) {
          if (order.runningMachine != null) {
            runningMachinesInOrder = order.runningMachine!;
          }
          runningMachinesInOrder.add(runningMachineModel);
          order.runningMachine = runningMachinesInOrder;
          await orderDbHelper.updateOrder(order);
        }

        MachineDbHelper machineDbHelper = MachineDbHelper();
        OrderWiseRunningMachineDbHelper runningMachineDbHelper = OrderWiseRunningMachineDbHelper();
        List<Machine> machines = await machineDbHelper.getMachineByMachineType(event.machineType);
        List<OrderWiseRunningMachineModel> runningOrders = [];
        for (Machine machine in machines) {
          List<OrderWiseRunningMachineModel> orders = await runningMachineDbHelper.getRunningOrdersOfMachine(machine.machineNumber);
          runningOrders.addAll(orders);  // Add the orders to the runningOrders list
        }
        emit(AssignOrderPageLoaded(machines: machines, runningMachines: runningOrders));
      } catch (error) {
        emit(AssignOrderPageError(error.toString()));
      }
    });
  }
}
