import 'package:coding_platform/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'codeforces.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create tables
        await db.execute('''
        CREATE TABLE users(
          isAdmin INTEGER,
          firstName TEXT,
          lastName TEXT,
          country TEXT,
          rating INTEGER,
          friendOfCount INTEGER,
          titlePhoto TEXT,
          handle TEXT PRIMARY KEY,
          avatar TEXT,
          contribution INTEGER,
          organization TEXT,
          rank TEXT,
          maxRating INTEGER,
          maxRank TEXT,
          upcomingContest TEXT,
          pastContest TEXT,
          pastContestLink TEXT,
          recentSubmission TEXT
        )
      ''');
      },
    );
  }

  // Insert a user into the database
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve a user by handle from the database
  Future<User?> getUserByHandle(String handle) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'handle = ?',
      whereArgs: [handle],
    );
    if (maps.isEmpty) {
      return null;
    } else {
      return User.fromMap(maps.first);
    }
  }

  // Update a user in the database
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'handle = ?',
      whereArgs: [user.handle],
    );
  }

  // Delete a user from the database
  Future<int> deleteUser(String handle) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'handle = ?',
      whereArgs: [handle],
    );
  }

  // Check if a handle exists in the database
  Future<bool> isAdminExist() async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['handle'],
      where: 'isAdmin = ?',
      whereArgs: [1], // Assuming isAdmin = 1 for the admin user
    );
    return result.isNotEmpty;
  }
}
