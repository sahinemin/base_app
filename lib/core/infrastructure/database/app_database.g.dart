// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodosTable extends Todos with TableInfo<$TodosTable, TodoDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobMeta = const VerificationMeta('job');
  @override
  late final GeneratedColumn<String> job = GeneratedColumn<String>(
    'job',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<Priority, int> priority =
      GeneratedColumn<int>(
        'priority',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Priority>($TodosTable.$converterpriority);
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    job,
    createdBy,
    expirationDate,
    priority,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoDto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('job')) {
      context.handle(
        _jobMeta,
        job.isAcceptableOrUnknown(data['job']!, _jobMeta),
      );
    } else if (isInserting) {
      context.missing(_jobMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoDto.fromDb(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      job:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}job'],
          )!,
      createdBy:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}created_by'],
          )!,
      priority: $TodosTable.$converterpriority.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}priority'],
        )!,
      ),
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      ),
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }

  static TypeConverter<Priority, int> $converterpriority =
      const PriorityConverter();
}

class TodosCompanion extends UpdateCompanion<TodoDto> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> job;
  final Value<String> createdBy;
  final Value<DateTime?> expirationDate;
  final Value<Priority> priority;
  final Value<bool> isCompleted;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.job = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required String job,
    required String createdBy,
    this.expirationDate = const Value.absent(),
    required Priority priority,
    this.isCompleted = const Value.absent(),
  }) : createdAt = Value(createdAt),
       job = Value(job),
       createdBy = Value(createdBy),
       priority = Value(priority);
  static Insertable<TodoDto> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? job,
    Expression<String>? createdBy,
    Expression<DateTime>? expirationDate,
    Expression<int>? priority,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (job != null) 'job': job,
      if (createdBy != null) 'created_by': createdBy,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (priority != null) 'priority': priority,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  TodosCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String>? job,
    Value<String>? createdBy,
    Value<DateTime?>? expirationDate,
    Value<Priority>? priority,
    Value<bool>? isCompleted,
  }) {
    return TodosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      job: job ?? this.job,
      createdBy: createdBy ?? this.createdBy,
      expirationDate: expirationDate ?? this.expirationDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (job.present) {
      map['job'] = Variable<String>(job.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(
        $TodosTable.$converterpriority.toSql(priority.value),
      );
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('job: $job, ')
          ..write('createdBy: $createdBy, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('priority: $priority, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodosTable todos = $TodosTable(this);
  late final TodoDao todoDao = TodoDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}

typedef $$TodosTableCreateCompanionBuilder =
    TodosCompanion Function({
      Value<int> id,
      required DateTime createdAt,
      required String job,
      required String createdBy,
      Value<DateTime?> expirationDate,
      required Priority priority,
      Value<bool> isCompleted,
    });
typedef $$TodosTableUpdateCompanionBuilder =
    TodosCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<String> job,
      Value<String> createdBy,
      Value<DateTime?> expirationDate,
      Value<Priority> priority,
      Value<bool> isCompleted,
    });

class $$TodosTableFilterComposer extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get job => $composableBuilder(
    column: $table.job,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Priority, Priority, int> get priority =>
      $composableBuilder(
        column: $table.priority,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodosTableOrderingComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get job => $composableBuilder(
    column: $table.job,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get job =>
      $composableBuilder(column: $table.job, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Priority, int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );
}

class $$TodosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodosTable,
          TodoDto,
          $$TodosTableFilterComposer,
          $$TodosTableOrderingComposer,
          $$TodosTableAnnotationComposer,
          $$TodosTableCreateCompanionBuilder,
          $$TodosTableUpdateCompanionBuilder,
          (TodoDto, BaseReferences<_$AppDatabase, $TodosTable, TodoDto>),
          TodoDto,
          PrefetchHooks Function()
        > {
  $$TodosTableTableManager(_$AppDatabase db, $TodosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> job = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
                Value<Priority> priority = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => TodosCompanion(
                id: id,
                createdAt: createdAt,
                job: job,
                createdBy: createdBy,
                expirationDate: expirationDate,
                priority: priority,
                isCompleted: isCompleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime createdAt,
                required String job,
                required String createdBy,
                Value<DateTime?> expirationDate = const Value.absent(),
                required Priority priority,
                Value<bool> isCompleted = const Value.absent(),
              }) => TodosCompanion.insert(
                id: id,
                createdAt: createdAt,
                job: job,
                createdBy: createdBy,
                expirationDate: expirationDate,
                priority: priority,
                isCompleted: isCompleted,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodosTable,
      TodoDto,
      $$TodosTableFilterComposer,
      $$TodosTableOrderingComposer,
      $$TodosTableAnnotationComposer,
      $$TodosTableCreateCompanionBuilder,
      $$TodosTableUpdateCompanionBuilder,
      (TodoDto, BaseReferences<_$AppDatabase, $TodosTable, TodoDto>),
      TodoDto,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db, _db.todos);
}

mixin _$TodoDaoMixin on DatabaseAccessor<AppDatabase> {
  $TodosTable get todos => attachedDatabase.todos;
}
