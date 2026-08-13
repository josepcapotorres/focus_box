// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_current_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryCurrentFilter)
const historyCurrentFilterProvider = HistoryCurrentFilterProvider._();

final class HistoryCurrentFilterProvider
    extends $NotifierProvider<HistoryCurrentFilter, HistoryRange> {
  const HistoryCurrentFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyCurrentFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyCurrentFilterHash();

  @$internal
  @override
  HistoryCurrentFilter create() => HistoryCurrentFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryRange value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryRange>(value),
    );
  }
}

String _$historyCurrentFilterHash() =>
    r'cd846ef171d9c01dfa57be899493583a655d90ae';

abstract class _$HistoryCurrentFilter extends $Notifier<HistoryRange> {
  HistoryRange build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HistoryRange, HistoryRange>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HistoryRange, HistoryRange>,
              HistoryRange,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
