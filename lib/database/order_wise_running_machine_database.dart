import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderWiseRunningMachineDatabase {
  static final OrderWiseRunningMachineDatabase instance = OrderWiseRunningMachineDatabase._init();
  static Database? _database;

  OrderWiseRunningMachineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('running_machines.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future _createTable(Database db, int version) async {
    const tableQuery = '''
      CREATE TABLE running_machines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        machineNumber TEXT, -- Foreign key to Machine table if needed
        quantity DOUBLE,
        balance DOUBLE,
        perDayProduction INTEGER,
        estimatedTimeToKnit TEXT,
        orderId INTEGER,
        FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE
      )
    ''';
    await db.execute(tableQuery);
  }
}
