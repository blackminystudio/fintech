import 'package:core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Injectable()
class PackageUtil {
  final PackageInfo _packageInfo;
  const PackageUtil(this._packageInfo);
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
}
