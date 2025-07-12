import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FakePackageInfo implements PackageInfo {
  @override
  String get appName => 'Test App';
  @override
  String get packageName => 'test';
  @override
  String get version => '1.0.0';
  @override
  String get buildNumber => '1';
  @override
  String get buildSignature => '';
  @override
  String get installerStore => '';

  @override
  Map<String, dynamic> get data => throw UnimplementedError();

  @override
  DateTime? get installTime => throw UnimplementedError();

  @override
  DateTime? get updateTime => throw UnimplementedError();
}

Future<GetIt> configureTestDependencies() async {
  final getIt = GetIt.instance;
  await getIt.reset();
  getIt.registerLazySingleton<PackageInfo>(FakePackageInfo.new);
  return getIt;
}
