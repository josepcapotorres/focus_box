// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FocusSession)
const focusSessionProvider = FocusSessionProvider._();

final class FocusSessionProvider
    extends $NotifierProvider<FocusSession, FocusSessionEntity?> {
  const FocusSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'focusSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$focusSessionHash();

  @$internal
  @override
  FocusSession create() => FocusSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FocusSessionEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FocusSessionEntity?>(value),
    );
  }
}

String _$focusSessionHash() => r'61e92093b8452ad269677de64943d6514fcd06c9';

abstract class _$FocusSession extends $Notifier<FocusSessionEntity?> {
  FocusSessionEntity? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FocusSessionEntity?, FocusSessionEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FocusSessionEntity?, FocusSessionEntity?>,
              FocusSessionEntity?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
