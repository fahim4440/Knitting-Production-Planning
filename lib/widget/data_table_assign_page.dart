import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knitting_production_planning/bloc/assign_order_page_bloc/assign_order_page_bloc.dart';
import 'package:knitting_production_planning/model/order_model.dart';
import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';
import 'package:knitting_production_planning/widget/input_text_field.dart';
import '../repository/format_date.dart';
import 'head_cell_container.dart';
import 'cell_container.dart';

Widget DataTableExcelAssignpage(AssignOrderPageLoaded state, BuildContext context, Order order) {
  final TextEditingController perDayProductionTextController = TextEditingController();
  final TextEditingController quantityTextController = TextEditingController();

  final List<DataColumn> headerColumn = [
    DataColumn(label: HeadCellContainer("Machine Number")),
    DataColumn(label: HeadCellContainer("Machine Dia"), numeric: true),
    DataColumn(label: HeadCellContainer("Machine Gauge"), numeric: true),
    DataColumn(label: HeadCellContainer("Machine Type")),
    DataColumn(label: HeadCellContainer("Order Load")),
  ];

  if (state.machines.isEmpty) {
    return const Center(child: Text("NO ORDER!", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),);
  }
  return DataTable(
    border: TableBorder.all(width: 1.0, color: Colors.grey),
    columns: headerColumn,
    rows: List<DataRow>.generate(state.machines.length, (index) {
      final machine = state.machines[index];
      List<OrderWiseRunningMachineModel> runningMachines = [];
      for (var runningMachine in state.runningMachines) {
        if (runningMachine.machineNumber == machine.machineNumber) {
          runningMachines.add(runningMachine);
        }
      }

      // To keep track of the cumulative estimated time
      DateTime? cumulativeEstimatedTime = runningMachines.isNotEmpty
          ? runningMachines.first.estimatedTimeToKnit
          : DateTime.now();
      return DataRow(cells: [
        DataCell(CellContainer(machine.machineNumber)),
        DataCell(CellContainer(machine.dia.toString())),
        DataCell(CellContainer(machine.gauge.toString())),
        DataCell(CellContainer(machine.machineType.toString().split(".").last)),
        DataCell(
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(runningMachines.length, (index) {
                  OrderWiseRunningMachineModel runningOrderMachine = runningMachines[index];
                  // Calculate the cumulative estimated time
                  DateTime? currentEstimatedTime = cumulativeEstimatedTime;
                  cumulativeEstimatedTime = currentEstimatedTime?.add(
                      Duration(days: (runningOrderMachine.balance /
                          (runningOrderMachine.averagePerDayProduction == 0
                              ? runningOrderMachine.perDayProduction
                              : runningOrderMachine.averagePerDayProduction))
                          .ceil()));
                  return Container(
                    width: runningOrderMachine.averagePerDayProduction == 0
                        ? (runningOrderMachine.balance / runningOrderMachine.perDayProduction) * 50
                        : (runningOrderMachine.balance / runningOrderMachine.averagePerDayProduction) * 50,
                    height: 30.0,
                    margin: const EdgeInsets.only(bottom: 2.0, top: 2.0, left: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.green, // Customize the color
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      "${order.orderNo}, ${order.color}, "
                          "Estimated Date: ${formatDateWithSuffix(currentEstimatedTime)}",
                      style: const TextStyle(fontSize: 8.0),
                    ),
                  );
                }),
              ),
              MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Order: ${order.orderNo}        Color: ${order.color}"),
                        content: SizedBox(
                          height: 200.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InputTextField(perDayProductionTextController, "Per Day Production"),
                              InputTextField(quantityTextController, "Quantity"),
                            ],
                          ),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              if (perDayProductionTextController.text != "" && quantityTextController.text != "") {
                                context.read<AssignOrderPageBloc>().add(AssignOrderToMachineEvent(
                                  perDayProduction: int.parse(perDayProductionTextController.text.trim()),
                                  quantity: int.parse(quantityTextController.text.trim()),
                                  machineNumber: machine.machineNumber,
                                  orderId: order.id!,
                                  machineType: machine.machineType,
                                ));
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("OK"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ]);
    }).toList(),
  );
}