import 'package:knitting_production_planning/model/machine_model.dart';

class OrderWiseRunningMachineModel {
  final String machineNumber;
  final double quantity;
  final double balance;
  final int perDayProduction;
  final DateTime? estimatedTimeToKnit;

  OrderWiseRunningMachineModel({
    required this.machineNumber,
    required this.quantity,
    required this.balance,
    required this.perDayProduction,
    this.estimatedTimeToKnit,
  });

  // Convert a JSON map to an Order object
  factory OrderWiseRunningMachineModel.fromJson(Map<String, dynamic> json) {
    return OrderWiseRunningMachineModel(
      // machine: Machine.fromJson(json['machine']),
      machineNumber: json['machineId'],
      quantity: json['quantity'],
      balance: json['balance'],
      perDayProduction: json['perDayProduction'],
      estimatedTimeToKnit: json['estimatedTimeToKnit'] != null
          ? DateTime.parse(json['estimatedKnitClosingDate'])
          : null,
    );
  }

  // Convert an Order object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      // 'machine': machine.toJson(),
      'machineId': machineNumber,
      'quantity': quantity,
      'balance': balance,
      'perDayProduction': perDayProduction,
      'estimatedKnitClosingDate': estimatedTimeToKnit?.toIso8601String(),
    };
  }
}
