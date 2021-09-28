import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        email TEXT,
        mobile TEXT,
        password TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'demo.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Insert New User
  static Future<int> createItem(String name, String email, String mobile, String password) async {
    final db = await SQLHelper.db();

    final data = {'name': name, 'email': email, 'mobile': mobile, 'password': password};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all Users
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: "id");
  }

  // Read a single user by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Read a single user by mobile and password
  static Future<List<Map<String, dynamic>>> getUser(String mobile, String password) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "mobile = ? and password = ?" , whereArgs: [mobile, password]);
  }

    // Read a single user by mobile and password
  static Future<List<Map<String, dynamic>>> searchMobile(String mobile) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "mobile = ?" , whereArgs: [mobile]);
  }

  // Update a user by id
  static Future<int> updateItem(
      int id, String name, String email, String mobile, String password) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password
    };

    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete user
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("users", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}