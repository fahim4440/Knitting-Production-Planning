import 'package:flutter/material.dart';
import 'package:knitting_production_planning/screen/assign_order_page.dart';
import '../bloc/planner_page_bloc/plannerpage_bloc.dart';
import 'head_cell_container.dart';
import 'cell_container.dart';

Widget DataTableExcelPlannerpage(PlannerpageLoadedState state, BuildContext context) {
  final List<DataColumn> headerColumn = [
    DataColumn(label: HeadCellContainer("Order No"), numeric: true,),
    DataColumn(label: HeadCellContainer("Buyer Name"),),
    DataColumn(label: HeadCellContainer("Fabric Type"),),
    // DataColumn(label: HeadCellContainer("Composition"),),
    DataColumn(label: HeadCellContainer("Color"),),
    DataColumn(label: HeadCellContainer("Machine Dia"), numeric: true,),
    DataColumn(label: HeadCellContainer("Machine Gauge"), numeric: true,),
    // DataColumn(label: HeadCellContainer("Finished Width",), numeric: true,),
    // DataColumn(label: HeadCellContainer("Finished GSM"), numeric: true,),
    DataColumn(label: HeadCellContainer("Open Type"),),
    // DataColumn(label: HeadCellContainer("Stitch Length"),),
    // DataColumn(label: HeadCellContainer("Count"),),
    // DataColumn(label: HeadCellContainer("Spinner"),),
    // DataColumn(label: HeadCellContainer("Lot"),),
    DataColumn(label: HeadCellContainer("Machine Type"),),
    DataColumn(label: HeadCellContainer("Running Machines"),),
    DataColumn(label: HeadCellContainer("Quantity"),),
    DataColumn(label: HeadCellContainer("Balance"),),
    DataColumn(label: HeadCellContainer("Status"),),
    DataColumn(label: HeadCellContainer("Estimated Knit Closing Date"),),
    DataColumn(label: HeadCellContainer("Order Closing Date"),),
  ];
  return state.orders.isNotEmpty ? DataTable(
    dataRowMaxHeight: 50,
    border: TableBorder.all(width: 1.0, color: Colors.grey),
    columns: headerColumn,
    rows: state.orders.map((order) {
      return DataRow(cells: [
        DataCell(CellContainer(order.orderNo)),
        DataCell(CellContainer(order.buyerName)),
        DataCell(CellContainer(order.fabricType)),
        // DataCell(CellContainer(order.composition)),
        DataCell(CellContainer(order.color)),
        DataCell(CellContainer(order.dia.toString())),
        DataCell(CellContainer(order.gauge.toString())),
        // DataCell(CellContainer(order.finishedWidth.toString())),
        // DataCell(CellContainer(order.finishedGSM.toString())),
        DataCell(CellContainer(order.openType.toString().split(".").last)),
        // DataCell(CellContainer(order.stitchLength)),
        // DataCell(CellContainer(order.count)),
        // DataCell(CellContainer(order.spinner)),
        // DataCell(CellContainer(order.lot)),
        DataCell(CellContainer(order.machineType.toString().split(".").last)),
        DataCell(MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AssignOrderPage(machineType: order.machineType, order: order,)));
          },
          child: order.runningMachine == null ? const Text("Click to Assign") : CellContainer(order.runningMachine!.length.toString()),
        )),
        DataCell(CellContainer(order.quantity.toString())),
        DataCell(CellContainer(order.balance.toString())),
        DataCell(CellContainer(order.status.toString().split(".").last)),
        order.estimatedKnitClosingDate == null ? const DataCell(Text("")) : DataCell(CellContainer(order.estimatedKnitClosingDate.toString().substring(0, 10))),
        DataCell(CellContainer(order.orderClosingDate.toString().substring(0, 10))),
      ]);
    }).toList(),
  ) : const Center(child: Text("NO ORDER!", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),);
}