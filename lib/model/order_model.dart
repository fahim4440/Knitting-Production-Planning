import 'dart:convert';

import 'package:knitting_production_planning/model/order_wise_running_machine_model.dart';
import 'machine_model.dart';

enum OrderStatus {
  Pending,
  Running,
  Closed,
  Cancelled,
}

enum FabricOpenType {
  Tube,
  Blade_Open,
  Needle_Open,
}


class Order {
  final int? id;
  final String orderNo;
  final String buyerName;
  final String fabricType;
  final String composition;
  final String color;
  final int dia;
  final int gauge;
  final int finishedGSM;
  final int finishedWidth;
  final FabricOpenType openType;
  final String stitchLength;
  final String count;
  final String spinner;
  final String lot;
  final MachineType machineType;
  List<OrderWiseRunningMachineModel>? runningMachine;
  final double quantity;
  final double balance;
  final OrderStatus status;
  DateTime? estimatedKnitClosingDate;
  final DateTime orderClosingDate;

  Order({
    this.id,
    required this.orderNo,
    required this.buyerName,
    required this.fabricType,
    required this.composition,
    required this.color,
    required this.dia,
    required this.gauge,
    required this.finishedGSM,
    required this.finishedWidth,
    required this.openType,
    required this.stitchLength,
    required this.count,
    required this.spinner,
    required this.lot,
    required this.machineType,
    this.runningMachine,
    required this.quantity,
    required this.balance,
    required this.status,
    this.estimatedKnitClosingDate,
    required this.orderClosingDate,
  });

  // Convert a JSON map to an Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 1,
      orderNo: json['orderNo'],
      buyerName: json['buyerName'],
      fabricType: json['fabricType'],
      composition: json['composition'],
      color: json['color'],
      dia: json['dia'],
      gauge: json['gauge'],
      finishedGSM: json['finishedGSM'],
      finishedWidth: json['finishedWidth'],
      openType: FabricOpenType.values[json['openType']],
      stitchLength: json['stitchLength'],
      count: json['count'],
      spinner: json['spinner'],
      lot: json['lot'],
      machineType: MachineType.values[json['machineType']],
      runningMachine: json['runningMachine'] != null
          ? (jsonDecode(json['runningMachine'] as String) as List).map((item) => OrderWiseRunningMachineModel.fromJson(item)).toList()
          : null,
      quantity: json['quantity'],
      balance: json['balance'],
      status: OrderStatus.values[json['status']],
      estimatedKnitClosingDate: json['estimatedKnitClosingDate'] != null
          ? DateTime.parse(json['estimatedKnitClosingDate'])
          : null,
      orderClosingDate: DateTime.parse(json['orderClosingDate']),
    );
  }

  // Convert an Order object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'orderNo': orderNo,
      'buyerName': buyerName,
      'fabricType': fabricType,
      'composition': composition,
      'color': color,
      'dia': dia,
      'gauge': gauge,
      'finishedGSM': finishedGSM,
      'finishedWidth': finishedWidth,
      'openType': openType.index,
      'stitchLength': stitchLength,
      'count': count,
      'spinner': spinner,
      'lot': lot,
      'machineType': machineType.index,
      'runningMachine': runningMachine != null ? jsonEncode(runningMachine!.map((item) => item.toJson()).toList()) : null,
      'quantity': quantity,
      'balance': balance,
      'status': status.index,
      'estimatedKnitClosingDate': estimatedKnitClosingDate?.toIso8601String(),
      'orderClosingDate': orderClosingDate.toIso8601String(),
    };
  }
}
