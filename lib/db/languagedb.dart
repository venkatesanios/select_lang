import 'package:path/path.dart';
import 'package:select_lang/model/languageModel.dart';
import 'package:sqflite/sqflite.dart';

class LanguageDatabase {
  static final LanguageDatabase instance = LanguageDatabase._init();

  static Database? _database;

  LanguageDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('language.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tablelanguage ( 
  ${LanguageFields.srno} $idType, 
  ${LanguageFields.defaultlang} $textType,
  ${LanguageFields.english} $textType,
  ${LanguageFields.tamil} $textType,
  ${LanguageFields.hindi} $textType,
  ${LanguageFields.kannada} $textType,
  ${LanguageFields.malayalam} $textType),
  ${LanguageFields.telugu} $textType)

''');
  }

  Future<Language> create(Language language) async {
    final db = await instance.database;

    final id = await db.insert(tablelanguage, language.toJson());
    return language.copy(srno: id);
  }

  Future<int> insertLanguage(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('language', row);
  }

  Future<Language> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablelanguage,
      columns: LanguageFields.values,
      where: '${LanguageFields.srno} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Language.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Language>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${LanguageFields.srno} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tablelanguage, orderBy: orderBy);

    return result.map((json) => Language.fromJson(json)).toList();
  }

  Future<int> update(Language language) async {
    final db = await instance.database;

    return db.update(
      tablelanguage,
      language.toJson(),
      where: '${LanguageFields.srno} = ?',
      whereArgs: [language.srno],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablelanguage,
      where: '${LanguageFields.srno} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
