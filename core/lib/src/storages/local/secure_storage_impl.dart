import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core.dart';

@Named('secure')
@LazySingleton(as: LocalStorage)
class SecureStorageImpl implements LocalStorage {
  SecureStorageImpl(this.storage);
  final FlutterSecureStorage storage;

  @override
  Future<dynamic> get(String key) async => storage.read(key: key);

  @override
  Future<bool> remove(String key) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (e, trace) {
      await getIt<Log>().console(
        e.toString(),
        type: LogType.error,
        stackTrace: trace,
      );

      return false;
    }
  }

  @override
  Future<bool> save(String key, dynamic value) async {
    try {
      await storage.write(key: key, value: value.toString());
      return true;
    } catch (e, trace) {
      await getIt<Log>().console(
        e.toString(),
        type: LogType.error,
        stackTrace: trace,
      );

      return false;
    }
  }

  @override
  Future<bool> has(String key) async =>
      Future.value(storage.containsKey(key: key));
}
