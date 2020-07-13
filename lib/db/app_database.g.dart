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

  FollowComicDAO _followComicDaoInstance;

  HistoryComicDAO _historyComicDaoInstance;

  DownloadComicDAO _downloadComicDaoInstance;

  ChapterComicDAO _chapterComicDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `FollowComic` (`id` INTEGER, `name` TEXT, `introduce` TEXT, `author` TEXT, `idThread` TEXT, `countChapter` INTEGER, `finish` INTEGER, `image` TEXT, `nominatedMonth` INTEGER, `avgRate` REAL, `chinaName` TEXT, `timeFix` INTEGER, `convertMonth` INTEGER, `tags` TEXT, `modPassMoney` INTEGER, `countNominated` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HistoryComic` (`id` INTEGER, `name` TEXT, `introduce` TEXT, `author` TEXT, `idThread` TEXT, `countChapter` INTEGER, `finish` INTEGER, `image` TEXT, `nominatedMonth` INTEGER, `avgRate` REAL, `chinaName` TEXT, `timeFix` INTEGER, `convertMonth` INTEGER, `tags` TEXT, `modPassMoney` INTEGER, `countNominated` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DownloadComic` (`id` INTEGER, `name` TEXT, `introduce` TEXT, `author` TEXT, `idThread` TEXT, `countChapter` INTEGER, `finish` INTEGER, `image` TEXT, `nominatedMonth` INTEGER, `avgRate` REAL, `chinaName` TEXT, `timeFix` INTEGER, `convertMonth` INTEGER, `tags` TEXT, `modPassMoney` INTEGER, `countNominated` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChapterComic` (`idChapter` INTEGER, `idComic` INTEGER, `nameIdChapter` TEXT, `contentTitleOfChapter` TEXT, `createdAt` TEXT, `updatedAt` TEXT, `vol` INTEGER, `content` TEXT, PRIMARY KEY (`idChapter`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FollowComicDAO get followComicDao {
    return _followComicDaoInstance ??=
        _$FollowComicDAO(database, changeListener);
  }

  @override
  HistoryComicDAO get historyComicDao {
    return _historyComicDaoInstance ??=
        _$HistoryComicDAO(database, changeListener);
  }

  @override
  DownloadComicDAO get downloadComicDao {
    return _downloadComicDaoInstance ??=
        _$DownloadComicDAO(database, changeListener);
  }

  @override
  ChapterComicDAO get chapterComicDao {
    return _chapterComicDaoInstance ??=
        _$ChapterComicDAO(database, changeListener);
  }
}

class _$FollowComicDAO extends FollowComicDAO {
  _$FollowComicDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _followComicInsertionAdapter = InsertionAdapter(
            database,
            'FollowComic',
            (FollowComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                }),
        _followComicUpdateAdapter = UpdateAdapter(
            database,
            'FollowComic',
            ['id'],
            (FollowComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                }),
        _followComicDeletionAdapter = DeletionAdapter(
            database,
            'FollowComic',
            ['id'],
            (FollowComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _followComicMapper = (Map<String, dynamic> row) => FollowComic(
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
      countNominated: row['countNominated'] as int);

  final InsertionAdapter<FollowComic> _followComicInsertionAdapter;

  final UpdateAdapter<FollowComic> _followComicUpdateAdapter;

  final DeletionAdapter<FollowComic> _followComicDeletionAdapter;

  @override
  Future<List<FollowComic>> getAllComic() async {
    return _queryAdapter.queryList('SELECT * FROM FollowComic',
        mapper: _followComicMapper);
  }

  @override
  Future<FollowComic> findComicById(int id) async {
    return _queryAdapter.query('SELECT * FROM FollowComic WHERE id = ?',
        arguments: <dynamic>[id], mapper: _followComicMapper);
  }

  @override
  Future<void> insertComic(FollowComic followComic) async {
    await _followComicInsertionAdapter.insert(
        followComic, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateComic(FollowComic followComic) async {
    await _followComicUpdateAdapter.update(
        followComic, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteComic(FollowComic followComic) async {
    await _followComicDeletionAdapter.delete(followComic);
  }
}

class _$HistoryComicDAO extends HistoryComicDAO {
  _$HistoryComicDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _historyComicInsertionAdapter = InsertionAdapter(
            database,
            'HistoryComic',
            (HistoryComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                }),
        _historyComicUpdateAdapter = UpdateAdapter(
            database,
            'HistoryComic',
            ['id'],
            (HistoryComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                }),
        _historyComicDeletionAdapter = DeletionAdapter(
            database,
            'HistoryComic',
            ['id'],
            (HistoryComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _historyComicMapper = (Map<String, dynamic> row) => HistoryComic(
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
      countNominated: row['countNominated'] as int);

  final InsertionAdapter<HistoryComic> _historyComicInsertionAdapter;

  final UpdateAdapter<HistoryComic> _historyComicUpdateAdapter;

  final DeletionAdapter<HistoryComic> _historyComicDeletionAdapter;

  @override
  Future<List<HistoryComic>> getAllComic() async {
    return _queryAdapter.queryList('SELECT * FROM HistoryComic',
        mapper: _historyComicMapper);
  }

  @override
  Future<HistoryComic> findComicById(int id) async {
    return _queryAdapter.query('SELECT * FROM HistoryComic WHERE id = ?',
        arguments: <dynamic>[id], mapper: _historyComicMapper);
  }

  @override
  Future<void> insertComic(HistoryComic historyComic) async {
    await _historyComicInsertionAdapter.insert(
        historyComic, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateComic(HistoryComic historyComic) async {
    await _historyComicUpdateAdapter.update(
        historyComic, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteComic(HistoryComic historyComic) async {
    await _historyComicDeletionAdapter.delete(historyComic);
  }
}

class _$DownloadComicDAO extends DownloadComicDAO {
  _$DownloadComicDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _downloadComicInsertionAdapter = InsertionAdapter(
            database,
            'DownloadComic',
            (DownloadComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                }),
        _downloadComicUpdateAdapter = UpdateAdapter(
            database,
            'DownloadComic',
            ['id'],
            (DownloadComic item) => <String, dynamic>{
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
                  'countNominated': item.countNominated
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _downloadComicMapper = (Map<String, dynamic> row) =>
      DownloadComic(
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
          countNominated: row['countNominated'] as int);

  final InsertionAdapter<DownloadComic> _downloadComicInsertionAdapter;

  final UpdateAdapter<DownloadComic> _downloadComicUpdateAdapter;

  @override
  Future<List<DownloadComic>> getAllComic() async {
    return _queryAdapter.queryList('SELECT * FROM DownloadComic',
        mapper: _downloadComicMapper);
  }

  @override
  Future<DownloadComic> findComicById(int id) async {
    return _queryAdapter.query('SELECT * FROM DownloadComic WHERE id = ?',
        arguments: <dynamic>[id], mapper: _downloadComicMapper);
  }

  @override
  Future<void> insertComic(DownloadComic downloadComic) async {
    await _downloadComicInsertionAdapter.insert(
        downloadComic, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateComic(DownloadComic downloadComic) async {
    await _downloadComicUpdateAdapter.update(
        downloadComic, OnConflictStrategy.abort);
  }
}

class _$ChapterComicDAO extends ChapterComicDAO {
  _$ChapterComicDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _chapterComicInsertionAdapter = InsertionAdapter(
            database,
            'ChapterComic',
            (ChapterComic item) => <String, dynamic>{
                  'idChapter': item.idChapter,
                  'idComic': item.idComic,
                  'nameIdChapter': item.nameIdChapter,
                  'contentTitleOfChapter': item.contentTitleOfChapter,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'vol': item.vol,
                  'content': item.content
                }),
        _chapterComicUpdateAdapter = UpdateAdapter(
            database,
            'ChapterComic',
            ['idChapter'],
            (ChapterComic item) => <String, dynamic>{
                  'idChapter': item.idChapter,
                  'idComic': item.idComic,
                  'nameIdChapter': item.nameIdChapter,
                  'contentTitleOfChapter': item.contentTitleOfChapter,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'vol': item.vol,
                  'content': item.content
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _chapterComicMapper = (Map<String, dynamic> row) => ChapterComic(
      idChapter: row['idChapter'] as int,
      idComic: row['idComic'] as int,
      nameIdChapter: row['nameIdChapter'] as String,
      contentTitleOfChapter: row['contentTitleOfChapter'] as String,
      createdAt: row['createdAt'] as String,
      updatedAt: row['updatedAt'] as String,
      vol: row['vol'] as int,
      content: row['content'] as String);

  final InsertionAdapter<ChapterComic> _chapterComicInsertionAdapter;

  final UpdateAdapter<ChapterComic> _chapterComicUpdateAdapter;

  @override
  Future<List<ChapterComic>> getAllComic() async {
    return _queryAdapter.queryList('SELECT * FROM ChapterComic',
        mapper: _chapterComicMapper);
  }

  @override
  Future<ChapterComic> findComicById(int idChapter) async {
    return _queryAdapter.query('SELECT * FROM ChapterComic WHERE idChapter = ?',
        arguments: <dynamic>[idChapter], mapper: _chapterComicMapper);
  }

  @override
  Future<List<ChapterComic>> findChapterByComic(int idComic) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ChapterComic WHERE idComic = ?',
        arguments: <dynamic>[idComic],
        mapper: _chapterComicMapper);
  }

  @override
  Future<void> insertComic(ChapterComic chapterComic) async {
    await _chapterComicInsertionAdapter.insert(
        chapterComic, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateComic(ChapterComic chapterComic) async {
    await _chapterComicUpdateAdapter.update(
        chapterComic, OnConflictStrategy.abort);
  }
}
