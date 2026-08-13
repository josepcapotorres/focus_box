import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crash_reporter.g.dart';

class CrashReporter {
  final FirebaseCrashlytics _crashlytics;

  const CrashReporter(this._crashlytics);

  void log(String message) => _crashlytics.log(message);

  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) {
    return _crashlytics.recordError(error, stackTrace, reason: reason);
  }

  Future<void> setCustomKey(String key, Object value) async {
    _crashlytics.setCustomKey(key, value);
  }
}

@riverpod
CrashReporter crashReporter(Ref ref) {
  return CrashReporter(FirebaseCrashlytics.instance);
}
