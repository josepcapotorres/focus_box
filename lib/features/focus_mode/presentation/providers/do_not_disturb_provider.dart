import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/do_not_disturb_repository.dart';

part 'do_not_disturb_provider.g.dart';

@riverpod
class DoNotDisturb extends _$DoNotDisturb {
  @override
  Future<bool> build() async {
    return await ref.watch(doNotDisturbRepositoryProvider).isDndEnabled;
  }

  Future<void> enableDNDMode() async {
    bool enabled;

    final repository = ref.read(doNotDisturbRepositoryProvider);
    enabled = await repository.enableDNDMode();

    state = AsyncData(enabled);
  }

  Future<void> disableDNDMode() async {
    bool isDisabled;

    final repository = ref.read(doNotDisturbRepositoryProvider);
    isDisabled = await repository.disableDNDMode();

    state = AsyncData(!isDisabled);
  }

  Future<void> refresh() async {
    final repository = ref.read(doNotDisturbRepositoryProvider);
    final enabled = await repository.isDndEnabled;

    if (state.value == enabled) {
      return;
    }

    state = AsyncData(enabled);
  }
}
