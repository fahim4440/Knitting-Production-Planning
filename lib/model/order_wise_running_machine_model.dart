import 'package:knitting_production_planning/model/machine_model.dart';

class OrderWiseRunningMachineModel {
  final int orderId;
  final String machineNumber;
  final int quantity;
  final int balance;
  final int perDayProduction;
  int averagePerDayProduction;
  int roll;
  final DateTime estimatedTimeToKnit;

  OrderWiseRunningMachineModel({
    required this.orderId,
    required this.machineNumber,
    required this.quantity,
    required this.balance,
    required this.perDayProduction,
    required this.averagePerDayProduction,
    required this.roll,
    required this.estimatedTimeToKnit,
  });

  // Convert a JSON map to an Order object
  factory OrderWiseRunningMachineModel.fromJson(Map<String, dynamic> json) {
    return OrderWiseRunningMachineModel(
      // machine: Machine.fromJson(json['machine']),
      orderId: json['orderId'],
      machineNumber: json['machineNumber'],
      quantity: json['quantity'],
      balance: json['balance'],
      perDayProduction: json['perDayProduction'],
      averagePerDayProduction: json['averagePerDayProduction'],
      roll: json['roll'],
      estimatedTimeToKnit: DateTime.parse(json['estimatedTimeToKnit']),
    );
  }

  // Convert an Order object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      // 'machine': machine.toJson(),
      'orderId': orderId,
      'machineNumber': machineNumber,
      'quantity': quantity,
      'balance': balance,
      'perDayProduction': perDayProduction,
      'averagePerDayProduction': averagePerDayProduction,
      'roll': roll,
      'estimatedTimeToKnit': estimatedTimeToKnit.toIso8601String(),
    };
  }
}
