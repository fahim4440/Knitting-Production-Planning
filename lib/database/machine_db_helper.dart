import 'dart:convert';

import '../model/machine_model.dart';
import 'machine_database.dart';

class MachineDbHelper {
  MachineDatabase instance = MachineDatabase.instance;

  Future<void> createMachine(Machine machine) async {
    final db = await instance.database;
    await db.insert('machines', machine.toJson());
  }

  Future<Machine?> getMachine(int machineNumber) async {
    final db = await instance.database;
    final maps = await db.query(
      'machines',
      where: 'machineNumber = ?',
      whereArgs: [machineNumber],
    );

    if (maps.isNotEmpty) {
      return Machine.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Machine>> getMachineByMachineType(MachineType machineType) async {
    final db = await instance.database;
    final maps = await db.query(
      'machines',
      where: 'machineType = ?',
      whereArgs: [machineType.toString().split(".").last],
    );

    if(maps.isNotEmpty) {
      return maps.map((json) => Machine.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<Machine>> getAllMachines() async {
    final db = await instance.database;
    final result = await db.query('machines');
    return result.map((json) => Machine.fromJson(json)).toList();
  }

  Future<int> updateMachine(Machine machine) async {
    final db = await instance.database;
    return db.update(
      'machines',
      machine.toJson(),
      where: 'machineNumber = ?',
      whereArgs: [machine.machineNumber],
    );
  }

  Future<int> deleteMachine(int machineNumber) async {
    final db = await instance.database;
    return db.delete(
      'machines',
      where: 'machineNumber = ?',
      whereArgs: [machineNumber],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}