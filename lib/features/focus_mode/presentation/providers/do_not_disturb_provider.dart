import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/managers/crash_reporter.dart';
import '../../domain/repositories/do_not_disturb_repository.dart';

part 'do_not_disturb_provider.g.dart';

@riverpod
class DoNotDisturb extends _$DoNotDisturb {
  @override
  Future<bool> build() async {
    try {
      return await ref.watch(doNotDisturbRepositoryProvider).isDndEnabled;
    } catch (e, s) {
      await ref.read(crashReporterProvider).recordError(e, s);
      return false;
    }
  }

  void enableDNDMode() async {
    bool enabled;

    try {
      final repository = ref.read(doNotDisturbRepositoryProvider);
      enabled = await repository.enableDNDMode();
    } catch (e, s) {
      enabled = false;
      await ref.read(crashReporterProvider).recordError(e, s);
    }

    state = AsyncData(enabled);
  }

  void disableDNDMode() async {
    bool isDisabled;

    try {
      final repository = ref.read(doNotDisturbRepositoryProvider);
      isDisabled = await repository.disableDNDMode();
    } catch (e, s) {
      isDisabled = true;
      await ref.read(crashReporterProvider).recordError(e, s);
    }

    state = AsyncData(!isDisabled);
  }

  Future<void> refresh() async {
    try {
      final repository = ref.read(doNotDisturbRepositoryProvider);
      final enabled = await repository.isDndEnabled;

      if (state.value == enabled) {
        return;
      }

      state = AsyncData(enabled);
    } catch (e, st) {
      ref.read(crashReporterProvider).recordError(e, st);
      state = AsyncError(e, st);
    }
  }
}
