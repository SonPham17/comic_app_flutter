// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ComicDAO _comicDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Comic` (`id` INTEGER, `name` TEXT, `introduce` TEXT, `author` TEXT, `idThread` TEXT, `countChapter` INTEGER, `finish` INTEGER, `image` TEXT, `nominatedMonth` INTEGER, `avgRate` REAL, `chinaName` TEXT, `timeFix` INTEGER, `convertMonth` INTEGER, `tags` TEXT, `modPassMoney` INTEGER, `countNominated` INTEGER, `isLiked` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ComicDAO get comicDao {
    return _comicDaoInstance ??= _$ComicDAO(database, changeListener);
  }
}

class _$ComicDAO extends ComicDAO {
  _$ComicDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _comicInsertionAdapter = InsertionAdapter(
            database,
            'Comic',
            (Comic item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'introduce': item.introduce,
                  'author': item.author,
                  'idThread': item.idThread,
                  'countChapter': item.countChapter,
                  'finish': item.finish,
                  'image': item.image,
                  'nominatedMonth': item.nominatedMonth,
                  'avgRate': item.avgRate,
                  'chinaName': item.chinaName,
                  'timeFix': item.timeFix,
                  'convertMonth': item.convertMonth,
                  'tags': item.tags,
                  'modPassMoney': item.modPassMoney,
                  'countNominated': item.countNominated,
                  'isLiked':
                      item.isLiked == null ? null : (item.isLiked ? 1 : 0)
                }),
        _comicUpdateAdapter = UpdateAdapter(
            database,
            'Comic',
            ['id'],
            (Comic item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'introduce': item.introduce,
                  'author': item.author,
                  'idThread': item.idThread,
                  'countChapter': item.countChapter,
                  'finish': item.finish,
                  'image': item.image,
                  'nominatedMonth': item.nominatedMonth,
                  'avgRate': item.avgRate,
                  'chinaName': item.chinaName,
                  'timeFix': item.timeFix,
                  'convertMonth': item.convertMonth,
                  'tags': item.tags,
                  'modPassMoney': item.modPassMoney,
                  'countNominated': item.countNominated,
                  'isLiked':
                      item.isLiked == null ? null : (item.isLiked ? 1 : 0)
                }),
        _comicDeletionAdapter = DeletionAdapter(
            database,
            'Comic',
            ['id'],
            (Comic item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'introduce': item.introduce,
                  'author': item.author,
                  'idThread': item.idThread,
                  'countChapter': item.countChapter,
                  'finish': item.finish,
                  'image': item.image,
                  'nominatedMonth': item.nominatedMonth,
                  'avgRate': item.avgRate,
                  'chinaName': item.chinaName,
                  'timeFix': item.timeFix,
                  'convertMonth': item.convertMonth,
                  'tags': item.tags,
                  'modPassMoney': item.modPassMoney,
                  'countNominated': item.countNominated,
                  'isLiked':
                      item.isLiked == null ? null : (item.isLiked ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _comicMapper = (Map<String, dynamic> row) => Comic(
      id: row['id'] as int,
      name: row['name'] as String,
      introduce: row['introduce'] as String,
      author: row['author'] as String,
      idThread: row['idThread'] as String,
      countChapter: row['countChapter'] as int,
      finish: row['finish'] as int,
      image: row['image'] as String,
      nominatedMonth: row['nominatedMonth'] as int,
      avgRate: row['avgRate'] as double,
      chinaName: row['chinaName'] as String,
      timeFix: row['timeFix'] as int,
      convertMonth: row['convertMonth'] as int,
      tags: row['tags'] as String,
      modPassMoney: row['modPassMoney'] as int,
      countNominated: row['countNominated'] as int,
      isLiked: row['isLiked'] == null ? null : (row['isLiked'] as int) != 0);

  final InsertionAdapter<Comic> _comicInsertionAdapter;

  final UpdateAdapter<Comic> _comicUpdateAdapter;

  final DeletionAdapter<Comic> _comicDeletionAdapter;

  @override
  Future<List<Comic>> getAllComic() async {
    return _queryAdapter.queryList('SELECT * FROM Comic', mapper: _comicMapper);
  }

  @override
  Future<Comic> findComicById(int id) async {
    return _queryAdapter.query('SELECT * FROM Comic WHERE id = ?',
        arguments: <dynamic>[id], mapper: _comicMapper);
  }

  @override
  Future<int> insertComic(Comic comic) {
    return _comicInsertionAdapter.insertAndReturnId(
        comic, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateComic(Comic comic) {
    return _comicUpdateAdapter.updateAndReturnChangedRows(
        comic, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteComic(Comic comic) {
    return _comicDeletionAdapter.deleteAndReturnChangedRows(comic);
  }
}
