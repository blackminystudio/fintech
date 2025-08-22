// coverage:ignore-file
import 'package:core/core.dart';
import 'package:google_sign_in/google_sign_in.dart';

@module
abstract class ServiceModule {
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();
}
