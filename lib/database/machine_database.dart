import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MachineDatabase {
  static final MachineDatabase instance = MachineDatabase._init();
  static Database? _database;

  MachineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('machine.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const machineTable = '''
    CREATE TABLE machines (
      machineNumber TEXT PRIMARY KEY,
      dia INTEGER,
      gauge INTEGER,
      machineBrand TEXT,
      machineType INTEGER,
      floorName INTEGER
    )
    ''';
    await db.execute(machineTable);
  }
}
