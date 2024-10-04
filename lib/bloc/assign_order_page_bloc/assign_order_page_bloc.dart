import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knitting_production_planning/model/machine_model.dart';
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
        machines.forEach((machine) async {
          runningOrders = await runningMachineDbHelper.getRunningOrdersOfMachine(machine.machineNumber);
        });
        emit(AssignOrderPageLoaded(machines: machines, runningMachines: runningOrders));
      } catch(error) {
        emit(AssignOrderPageError(error.toString()));
      }
    });
  }
}
