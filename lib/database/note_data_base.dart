import 'package:day_note_/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dayNote.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    // await db.execute('''
    // CREATE TABLE $tableNotes(
    // ${NoteFields.id} $idType,
    // ${NoteFields.isImportant} $boolType,
    // ${NoteFields.number} $integerType,
    // ${NoteFields.title} $textType,
    // ${NoteFields.description} $textType,
    // ${NoteFields.time} $textType,
    // )
    // ''');

    await db.execute('CREATE TABLE $tableNotes('
        ' ${NoteFields.id} $idType,'
        ' ${NoteFields.isImportant} $boolType,'
        ' ${NoteFields.number} $integerType,'
        ' ${NoteFields.title} $textType,'
        ' ${NoteFields.description} $textType,'
        ' ${NoteFields.time} $textType)');
  }

  Future<NoteModel> create(NoteModel noteModel) async {
    final db = await instance.database;
    // final json = noteModel.toJson();
    // final columns = '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values = '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert(tableNotes, noteModel.toJson());
    return noteModel.copy(id: id);
  }

  Future<NoteModel> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return NoteModel.fromJson(maps.first);
    } else {
      throw Exception('ID: $id not fount');
    }
  }

  Future<List<NoteModel>> readAllNote() async {
    final db = await instance.database;
    const orderBy = '${NoteFields.time} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableNotes, orderBy: orderBy);
    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  Future<int> update(NoteModel noteModel) async {
    final db = await instance.database;
    return db.update(
      tableNotes,
      noteModel.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [noteModel.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}