// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'do_not_disturb_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DoNotDisturb)
const doNotDisturbProvider = DoNotDisturbProvider._();

final class DoNotDisturbProvider
    extends $AsyncNotifierProvider<DoNotDisturb, bool> {
  const DoNotDisturbProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doNotDisturbProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doNotDisturbHash();

  @$internal
  @override
  DoNotDisturb create() => DoNotDisturb();
}

String _$doNotDisturbHash() => r'1425060bc5a8b6eeea64f215b5f6819599087179';

abstract class _$DoNotDisturb extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
