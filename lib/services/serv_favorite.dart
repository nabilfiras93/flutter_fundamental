import 'package:restaurantfinal/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteService {
  static late Database _database;
  static FavoriteService? _databaseHelper;
  static const String _tableName = 'restaurants';

  FavoriteService._internal() {
    _databaseHelper = this;
  }

  factory FavoriteService() => _databaseHelper ?? FavoriteService._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(join(path, 'restaurant_db.db'),
        onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE $_tableName (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXt,
              rating DOUBLE
            )
          ''');
    }, version: 1);

    return db;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> addToFavorite(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toJson());
  }

  Future<List<Restaurant>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
  }

  Future<Restaurant> getRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (results.isEmpty) {
      throw "NotFound";
    } else {
      return results.map((res) => Restaurant.fromJson(res)).first;
    }
  }

  Future<void> deleteFavoriteRestaurant(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> checkIsFavorite(String id) async {
    try {
      await getRestaurantById(id);
      return true;
    } catch (error) {
      return false;
    }
  }
}
