import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderDatabase {
  static final OrderDatabase instance = OrderDatabase._init();
  static const String tableName = "order.db";
  static Database? _database;

  OrderDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(tableName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const orderTable = '''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      orderNo TEXT,
      buyerName TEXT,
      fabricType TEXT,
      composition TEXT,
      color TEXT,
      dia INTEGER,
      gauge INTEGER,
      finishedGSM INTEGER,
      finishedWidth INTEGER,
      openType INTEGER,
      stitchLength TEXT,
      count TEXT,
      spinner TEXT,
      lot TEXT,
      machineType INTEGER,
      runningMachine TEXT,
      quantity REAL,
      balance REAL,
      status INTEGER,
      estimatedKnitClosingDate TEXT,
      orderClosingDate TEXT
    )
    ''';
    await db.execute(orderTable);
  }

  Future<void> deleteOrderDatabase() async {
    final dbPath = await getDatabasesPath();
    final String path = join(dbPath, tableName);
    await deleteDatabase(path);
    _database = null; // Reset the database instance
  }
}
