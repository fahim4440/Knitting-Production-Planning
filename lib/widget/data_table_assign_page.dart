import 'package:flutter/material.dart';
import 'package:knitting_production_planning/bloc/assign_order_page_bloc/assign_order_page_bloc.dart';
import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';
import 'package:knitting_production_planning/screen/assign_order_page.dart';
import 'head_cell_container.dart';
import 'cell_container.dart';


Widget DataTableExcelAssignpage(AssignOrderPageLoaded state, BuildContext context) {
  final List<DataColumn> headerColumn = [
    DataColumn(label: HeadCellContainer("Machine Number")),
    DataColumn(label: HeadCellContainer("Machine Dia"), numeric: true),
    DataColumn(label: HeadCellContainer("Machine Gauge"), numeric: true),
    DataColumn(label: HeadCellContainer("Machine Type")),
    DataColumn(label: HeadCellContainer("Order Load")),
  ];

  return state.machines.isNotEmpty
      ? DataTable(
    dataRowMaxHeight: 50,
    border: TableBorder.all(width: 1.0, color: Colors.grey),
    columns: headerColumn,
    rows: state.machines.map((machine) {
      List<OrderWiseRunningMachineModel> runningMachines = [];
      state.runningMachines.forEach((runningMachine) {
        if (runningMachine.machineNumber == machine.machineNumber) {
          runningMachines.add(runningMachine);
        }
      });

      return DataRow(cells: [
        DataCell(CellContainer(machine.machineNumber)),
        DataCell(CellContainer(machine.dia.toString())),
        DataCell(CellContainer(machine.gauge.toString())),
        DataCell(CellContainer(machine.machineType.toString().split(".").last)),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: runningMachines.map((runningOrderMachine) {
              return Container(
                width: (runningOrderMachine.balance / runningOrderMachine.perDayProduction) * 10,
                height: 30.0,
                padding: EdgeInsets.only(
                    left: runningMachines.indexOf(runningOrderMachine) != 0
                        ? (runningMachines[runningMachines.indexOf(runningOrderMachine) - 1].balance /
                        runningMachines[runningMachines.indexOf(runningOrderMachine) - 1].perDayProduction) *
                        10
                        : 0.0),
                decoration: BoxDecoration(
                  color: Colors.green, // Customize the color
                  border: Border.all(color: Colors.black),
                ),
              );
            }).toList()
              ..add(Container(
                child: MaterialButton(
                  onPressed: () {

                  },
                  child: const Icon(Icons.add),
                ),
              )),
          ),
        ),
      ]);
    }).toList(),
  )
      : const Center(
    child: Text(
      "NO ORDER!",
      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    ),
  );
}
// Widget DataTableExcelAssignpage(AssignOrderPageLoaded state, BuildContext context) {
//   final List<DataColumn> headerColumn = [
//     // DataColumn(label: HeadCellContainer("Floor"),),
//     DataColumn(label: HeadCellContainer("Machine Number"),),
//     DataColumn(label: HeadCellContainer("Machine Dia"), numeric: true,),
//     DataColumn(label: HeadCellContainer("Machine Gauge"), numeric: true,),
//     DataColumn(label: HeadCellContainer("Machine Type"),),
//     DataColumn(label: HeadCellContainer("Order Load"),),
//   ];
//   return state.machines.isNotEmpty ? DataTable(
//     dataRowMaxHeight: 50,
//     border: TableBorder.all(width: 1.0, color: Colors.grey),
//     columns: headerColumn,
//     rows: state.machines.map((machine) {
//       List<OrderWiseRunningMachineModel> runningMachines = [];
//       state.runningMachines.forEach((runningMachine) {
//         if(runningMachine.machineNumber == machine.machineNumber) {
//           runningMachines.add(runningMachine);
//         }
//       });
//       return DataRow(cells: [
//         DataCell(CellContainer(machine.machineNumber)),
//         DataCell(CellContainer(machine.dia.toString())),
//         DataCell(CellContainer(machine.gauge.toString())),
//         DataCell(CellContainer(machine.machineType.toString().split(".").last)),
//         DataCell(Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [ListView.builder(
//             itemCount: runningMachines.length + 1,
//             itemBuilder: (context, index) {
//               OrderWiseRunningMachineModel runningOrderMachine = runningMachines[index];
//               if (index == runningMachines.length) {
//                 return MaterialButton(
//                   onPressed: () {},
//                   child: const Icon(Icons.add),
//                 );
//               } else if (index < runningMachines.length) {
//                 return Container(
//                   width: (runningOrderMachine.balance/runningOrderMachine.perDayProduction) * 10,
//                   height: 30.0,
//                   padding: index != 0 ?  EdgeInsets.only(left: (runningMachines[index - 1].balance/runningMachines[index - 1].perDayProduction) * 10) : EdgeInsets.zero,
//                 );
//               } else {
//                 return const SizedBox();
//               }
//             },
//           ),]
//         )),
//       ]);
//     }).toList(),
//   ) : const Center(child: Text("NO ORDER!", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),);
// }