import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/order.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId TEXT,
        name TEXT,
        phone TEXT,
        service TEXT,
        items INTEGER,
        price REAL,
        total REAL,
        status TEXT
      )
    ''');
  }

  // INSERT
	Future<int> insertOrder(Order order) async {
	final db = await instance.database;

	final data = order.toMap();
	data.remove('id');

	return await db.insert('orders', data);
	}

  // GET ALL
  Future<List<Order>> getOrders() async {
    final db = await instance.database;
	final result = await db.query('orders', orderBy: 'id DESC');

    return result.map((json) => Order.fromMap(json)).toList();
  }

  // UPDATE STATUS
  Future<int> updateOrder(Order order) async {
    final db = await instance.database;

    return db.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }
  
}