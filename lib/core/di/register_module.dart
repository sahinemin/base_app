import 'package:base_app/core/infrastructure/database/app_database.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:injectable/injectable.dart';


@module
abstract class RegisterModule {
  // Register AppDatabase as a singleton
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase(
    driftDatabase(
      name: 'todo-app',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Using ${result.chosenImplementation} due to unsupported '
              'browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
    ),
  );

  // Provide TodoDao based on AppDatabase instance
  @lazySingleton
  TodoDao get todoDao => appDatabase.todoDao;

  // If you add SettingsDao etc., provide them here too:
  // @lazySingleton
  // SettingsDao get settingsDao => appDatabase.settingsDao;
}
