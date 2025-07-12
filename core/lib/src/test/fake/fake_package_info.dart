import 'package:package_info_plus/package_info_plus.dart';

class FakePackageInfo implements PackageInfo {
  @override
  String get appName => 'Test App';

  @override
  String get packageName => 'com.example.test';

  @override
  String get version => '1.0.0';

  @override
  String get buildNumber => '1';

  @override
  String get buildSignature => 'test';

  @override
  String get installerStore => 'play';

  @override
  Map<String, dynamic> get data => {};

  @override
  DateTime? get installTime => DateTime.now();

  @override
  DateTime? get updateTime => DateTime.now();
}
