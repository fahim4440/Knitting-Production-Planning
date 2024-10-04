import 'order_wise_running_machine_database.dart';
import '../model/order_wise_running_machine_model.dart';
import '../model/machine_model.dart';
import 'machine_db_helper.dart';

class OrderWiseRunningMachineDbHelper {
  OrderWiseRunningMachineDatabase instance = OrderWiseRunningMachineDatabase.instance;

  // Insert a running machine record
  Future<int> insertRunningMachine(OrderWiseRunningMachineModel runningMachine, int orderId) async {
    final db = await instance.database;
    final runningMachineJson = runningMachine.toJson();
    print(runningMachineJson);
    runningMachineJson['orderId'] = orderId;
    return await db.insert('running_machines', runningMachineJson
      // 'running_machines',
      // {
      //   'machineId': runningMachine.machine.machineNumber,
      //   'quantity': runningMachine.quantity,
      //   'balance': runningMachine.balance,
      //   'perDayProduction': runningMachine.perDayProduction,
      //   'estimatedTimeToKnit': runningMachine.estimatedTimeToKnit,
      //   'orderId': orderId,
      // },
    );
  }

  Future<List<OrderWiseRunningMachineModel>> getRunningOrdersOfMachine(String machineNumber) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'running_machines',
      where: 'machineNumber = ?',
      whereArgs: [machineNumber],
    );
    List<OrderWiseRunningMachineModel> listOfOrdersRunningInMachine = [];
    for (var runningMachine in maps) {
      // Machine? machine = await MachineDbHelper().getMachine(runningMachine['machineId']);
      OrderWiseRunningMachineModel runningMachineModel = OrderWiseRunningMachineModel
          .fromJson(runningMachine);
      listOfOrdersRunningInMachine.add(runningMachineModel
        // OrderWiseRunningMachineModel(
        //   machine: machine!,
        //   quantity: runningMachine['quantity'],
        //   balance: runningMachine['balance'],
        // ),
      );
    }
    return listOfOrdersRunningInMachine;
  }

  // Fetch running machines by order ID
  Future<List<OrderWiseRunningMachineModel>> getRunningMachinesByOrderId(int orderId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'running_machines',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );

    List<OrderWiseRunningMachineModel> listOfRunningMachines = [];

    for (var runningMachine in maps) {
      // Machine? machine = await MachineDbHelper().getMachine(runningMachine['machineId']);
      OrderWiseRunningMachineModel runningMachineModel = OrderWiseRunningMachineModel.fromJson(runningMachine);
      listOfRunningMachines.add(runningMachineModel
        // OrderWiseRunningMachineModel(
        //   machine: machine!,
        //   quantity: runningMachine['quantity'],
        //   balance: runningMachine['balance'],
        // ),
      );
    }

    return listOfRunningMachines;
  }

  // Delete running machines by order ID
  Future<void> deleteRunningMachinesByOrderId(int orderId) async {
    final db = await instance.database;
    await db.delete(
      'running_machines',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
  }
}