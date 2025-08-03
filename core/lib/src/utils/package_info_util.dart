import 'package:package_info_plus/package_info_plus.dart';

import '../../core.dart';

@Injectable()
class PackageUtil {
  const PackageUtil(this._packageInfo);
  final PackageInfo _packageInfo;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
}
