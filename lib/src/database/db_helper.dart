import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/diferenciadas.dart';
import 'models/empregos.dart';
import 'models/horas.dart';
import 'models/salarios.dart';

Future<Database> getDB() async {
  return DbHelper().db;
}

class DbHelper {
  factory DbHelper() {
    return _instance;
  }

  DbHelper._();

  static final DbHelper _instance = DbHelper._();
  static Database _database;

  Future<Database> get db async {
    return _database ??= await _init();
  }

  Future<Database> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'marcaii.db');
    final db = openDatabase(
      path,
      version: 1,
      onCreate: _buildTables,
      onUpgrade: _upgradeTables,
    );

    return db;
  }

  FutureOr<void> _buildTables(Database db, int version) async {
    await db.execute(const Empregos().createSQL);
    await db.execute(const Horas().createSQL);
    await db.execute(const Salarios().createSQL);
    await db.execute(const Diferenciadas().createSQL);
  }

  FutureOr<void> _upgradeTables(Database db, int oldVersion, int newVersion) {
    //Implementar quando necessário
  }
}
