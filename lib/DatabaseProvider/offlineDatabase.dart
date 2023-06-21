
import 'package:crypto_traking_app/Model/CurrencyListModel.dart';
import 'package:crypto_traking_app/Model/currency_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static String dbName = 'Database.db';
  static Database? _database;
  static int? databaseVersion = 1;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, DatabaseHelper.dbName);
    return await openDatabase(path, version: databaseVersion,
        onCreate: _createDatabase,
        onUpgrade: (Database? db, int oldVersion, int newVersion) {
          print(newVersion);
          if (oldVersion < newVersion) {
          }
        });
  }


  void _createDatabase(Database db, int version) async {
    await db.execute('CREATE TABLE CryptoPriceHistory (id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' dateTime INTEGER,'
        ' currencyName TEXT,'
        ' usd REAL)');
  }

  Future<int> insertCurrencyPrice(CurrencyListModel currencyListModel) async {
    Database? db = await instance.database;
    int result = -1;
    for (Currency currency in currencyListModel.dataList!){
      Map<String, dynamic> currencyJsonData = currency.toJson();
      result = await db!.insert('CryptoPriceHistory',currencyJsonData);
    }
    return result;
  }
  Future<CurrencyListModel> getCurrencyPriceHistory() async {
    CurrencyListModel currencyListModel = CurrencyListModel();
    Database? db = await instance.database;

    List<Map<String, dynamic>> map  = await db!.rawQuery("SELECT * FROM CryptoPriceHistory ORDER BY dateTime DESC");
    List<Currency> allCurrencyPriceHostory = map.map((e) => Currency.fromJson(e)).toList();
    if (allCurrencyPriceHostory.length >0){
      currencyListModel.dataList = allCurrencyPriceHostory;
    }
    return currencyListModel;
  }

  static Future<int> deleteAll(String tableName) async {
    int result = 0;
    try {
      var dbClient = await _database;
      result = await dbClient!.delete(tableName);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }


}