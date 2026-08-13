import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/do_not_disturb_repository.dart';

part 'do_not_disturb_provider.g.dart';

@riverpod
class DoNotDisturb extends _$DoNotDisturb {
  @override
  Future<bool> build() async {
    print("TT donotdisturb provider build. ${DateTime.now()}");
    return await ref.watch(doNotDisturbRepositoryProvider).isDndEnabled;
  }

  void enableDNDMode() async {
    print("TT donotdisturb provider enableDNDMode(). ${DateTime.now()}");
    final repository = ref.read(doNotDisturbRepositoryProvider);
    final enabled = await repository.enableDNDMode();

    state = AsyncData(enabled);
  }

  void disableDNDMode() async {
    print("TT donotdisturb provider disableDNDMode(). ${DateTime.now()}");
    final repository = ref.read(doNotDisturbRepositoryProvider);
    final isDisabled = await repository.disableDNDMode();

    state = AsyncData(!isDisabled);
  }

  Future<void> refresh() async {
    print("TT donotdisturb provider refresh(). ${DateTime.now()}");
    try {
      final repository = ref.read(doNotDisturbRepositoryProvider);
      final enabled = await repository.isDndEnabled;

      if (state.value == enabled) {
        return;
      }

      state = AsyncData(enabled);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
