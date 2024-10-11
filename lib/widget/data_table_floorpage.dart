import 'package:flutter/material.dart';
import 'package:knitting_production_planning/bloc/floor_page_bloc/floor_page_bloc.dart';
import 'package:knitting_production_planning/model/order_model.dart';
import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';
import 'head_cell_container.dart';
import 'cell_container.dart';

Widget DataTableExcelFloorpage(FloorPageLoadedState state, BuildContext context) {
  final TextEditingController aRollController = TextEditingController();
  final TextEditingController aProductionTextController = TextEditingController();
  final TextEditingController bRollController = TextEditingController();
  final TextEditingController bProductionTextController = TextEditingController();
  final TextEditingController cRollController = TextEditingController();
  final TextEditingController cProductionTextController = TextEditingController();

  final List<DataColumn> headerColumn = [
    DataColumn(label: HeadCellContainer("Machine Number")),
    DataColumn(label: HeadCellContainer("Dia x Gauge"), numeric: true),
    DataColumn(label: HeadCellContainer("Order No")),
    DataColumn(label: HeadCellContainer("Buyer Name")),
    DataColumn(label: HeadCellContainer("Fabric Type")),
    DataColumn(label: HeadCellContainer("F. GSM")),
    DataColumn(label: HeadCellContainer("F. Width")),
    DataColumn(label: HeadCellContainer("Count")),
    DataColumn(label: HeadCellContainer("Yarn Lot")),
    DataColumn(label: HeadCellContainer("Color")),
    DataColumn(label: HeadCellContainer("A Shift")),
    DataColumn(label: HeadCellContainer("Roll")),
    DataColumn(label: HeadCellContainer("Production Quantity")),
    DataColumn(label: HeadCellContainer("B Shift")),
    DataColumn(label: HeadCellContainer("Roll")),
    DataColumn(label: HeadCellContainer("Production Quantity")),
    DataColumn(label: HeadCellContainer("C Shift")),
    DataColumn(label: HeadCellContainer("Roll")),
    DataColumn(label: HeadCellContainer("Production Quantity")),
    DataColumn(label: HeadCellContainer("Balance")),
  ];

  if (state.machines.isEmpty) {
    return const Center(
      child: Text(
        "NO Machine!",
        style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
      ),
    );
  } else if (state.orderWiseRunningMachines.isEmpty) {
    return const Center(
      child: Text(
        "NO ORDER!",
        style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  return DataTable(
    border: TableBorder.all(width: 1.0, color: Colors.grey),
    columns: headerColumn,
    rows: state.machines.expand((machine) {
      List<OrderWiseRunningMachineModel> runningMachines = state.orderWiseRunningMachines
          .where((rm) => rm.machineNumber == machine.machineNumber)
          .toList();

      if (runningMachines.isEmpty) {
        // Return an empty row if the machine has no orders
        return [
          DataRow(cells: [
            DataCell(CellContainer(machine.machineNumber)),
            DataCell(CellContainer("${machine.dia} x ${machine.gauge}")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
            DataCell(CellContainer("")),
          ]),
        ];
      } else {
        // Match each OrderWiseRunningMachine with the corresponding Order
        return runningMachines.map((runningMachine) {
          // Get the corresponding Order for this running machine
          final Order order = state.orders.firstWhere(
                  (o) => o.id == runningMachine.orderId,);
          // Populate the DataRow using both the order and running machine details
          return DataRow(cells: [
            DataCell(CellContainer(machine.machineNumber)),
            DataCell(CellContainer("${machine.dia} x ${machine.gauge}")),
            DataCell(CellContainer(order.orderNo)),
            DataCell(CellContainer(order.buyerName)),
            DataCell(CellContainer(order.fabricType)),
            DataCell(CellContainer(order.finishedGSM.toString())),
            DataCell(CellContainer(order.finishedWidth.toString())),
            DataCell(CellContainer(order.count)),
            DataCell(CellContainer(order.lot)),
            DataCell(CellContainer(order.color)),
            DataCell(CellContainer("A Shift")),
            DataCell(TextField(controller: aRollController, keyboardType: TextInputType.number,)),
            DataCell(Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: aProductionTextController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Icon(Icons.save),
                ),
              ],
            )),
            DataCell(CellContainer("B Shift")),
            DataCell(TextField(controller: bRollController, keyboardType: TextInputType.number,)),
            DataCell(Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: bProductionTextController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Icon(Icons.save,),
                ),
              ],
            )),
            DataCell(CellContainer("C Shift")),
            DataCell(TextField(controller: cRollController, keyboardType: TextInputType.number,),),
            DataCell(Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: cProductionTextController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Icon(Icons.save,),
                ),
              ],
            )),
            DataCell(CellContainer(runningMachine.balance.toString())),
          ]);
        }).toList();
      }
    }).toList(),
  );
}



// import 'package:flutter/material.dart';
// import 'package:knitting_production_planning/bloc/floor_page_bloc/floor_page_bloc.dart';
// import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';
// import 'head_cell_container.dart';
// import 'cell_container.dart';
//
// Widget DataTableExcelFloorpage(FloorPageLoadedState state, BuildContext context) {
//   final TextEditingController aRollController = TextEditingController();
//   final TextEditingController aProductionTextController = TextEditingController();
//   final TextEditingController bRollController = TextEditingController();
//   final TextEditingController bProductionTextController = TextEditingController();
//   final TextEditingController cRollController = TextEditingController();
//   final TextEditingController cProductionTextController = TextEditingController();
//
//   final List<DataColumn> headerColumn = [
//     DataColumn(label: HeadCellContainer("Machine Number")),
//     DataColumn(label: HeadCellContainer("Dia x Gauge"), numeric: true),
//     DataColumn(label: HeadCellContainer("Order No")),
//     DataColumn(label: HeadCellContainer("Buyer Name")),
//     DataColumn(label: HeadCellContainer("Fabric Type")),
//     DataColumn(label: HeadCellContainer("F. GSM")),
//     DataColumn(label: HeadCellContainer("F. Width")),
//     DataColumn(label: HeadCellContainer("Count")),
//     DataColumn(label: HeadCellContainer("Yarn Lot")),
//     DataColumn(label: HeadCellContainer("Color")),
//     DataColumn(label: HeadCellContainer("A Shift")),
//     DataColumn(label: HeadCellContainer("Roll")),
//     DataColumn(label: HeadCellContainer("Production Quantity")),
//     DataColumn(label: HeadCellContainer("B Shift")),
//     DataColumn(label: HeadCellContainer("Roll")),
//     DataColumn(label: HeadCellContainer("Production Quantity")),
//     DataColumn(label: HeadCellContainer("C Shift")),
//     DataColumn(label: HeadCellContainer("Roll")),
//     DataColumn(label: HeadCellContainer("Production Quantity")),
//     DataColumn(label: HeadCellContainer("Balance")),
//   ];
//
//   if (state.machines.isEmpty) {
//     return const Center(child: Text("NO Machine!", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),);
//   } else if (state.orderWiseRunningMachines.isEmpty) {
//     return const Center(child: Text("NO ORDER!", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),);
//   }
//   return DataTable(
//     border: TableBorder.all(width: 1.0, color: Colors.grey),
//     columns: headerColumn,
//     rows: List<DataRow>.generate(state.machines.length, (index) {
//       final machine = state.machines[index];
//       List<OrderWiseRunningMachineModel> runningMachines = [];
//       for (var runningMachine in state.orderWiseRunningMachines) {
//         if (runningMachine.machineNumber == machine.machineNumber) {
//           runningMachines.add(runningMachine);
//         }
//       }
//       List<DataRow> dataRow = [];
//       for(OrderWiseRunningMachineModel runningMachineModel in runningMachines) {
//         dataRow.add(
//             DataRow(cells: [
//               DataCell(CellContainer(machine.machineNumber)),
//               DataCell(CellContainer("${machine.dia} x ${machine.gauge}")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer("")),
//               DataCell(CellContainer(runningMachineModel.balance.toString())),
//             ])
//         );
//       }
//       return dataRow;
//     }).toList(),
//   );
// }