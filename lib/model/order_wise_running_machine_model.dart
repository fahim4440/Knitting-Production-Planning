import 'package:knitting_production_planning/model/machineModel.dart';

class OrderWiseRunningMachineModel {
  final Machine machine;
  final double quantity;
  final double balance;

  OrderWiseRunningMachineModel({
    required this.machine,
    required this.quantity,
    required this.balance,
  });

  // Convert a JSON map to an Order object
  factory OrderWiseRunningMachineModel.fromJson(Map<String, dynamic> json) {
    return OrderWiseRunningMachineModel(
      machine: json['machine'],
      quantity: json['quantity'],
      balance: json['balance'],
    );
  }

  // Convert an Order object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'machine': machine,
      'quantity': quantity,
      'balance': balance,
    };
  }
}
