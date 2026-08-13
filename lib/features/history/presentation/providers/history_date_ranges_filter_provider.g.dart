// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_date_ranges_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(historyRateRangesFilter)
const historyRateRangesFilterProvider = HistoryRateRangesFilterProvider._();

final class HistoryRateRangesFilterProvider
    extends
        $FunctionalProvider<
          (DateTime, DateTime),
          (DateTime, DateTime),
          (DateTime, DateTime)
        >
    with $Provider<(DateTime, DateTime)> {
  const HistoryRateRangesFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyRateRangesFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyRateRangesFilterHash();

  @$internal
  @override
  $ProviderElement<(DateTime, DateTime)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  (DateTime, DateTime) create(Ref ref) {
    return historyRateRangesFilter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue((DateTime, DateTime) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<(DateTime, DateTime)>(value),
    );
  }
}

String _$historyRateRangesFilterHash() =>
    r'f5edbaa01f0106f98f919095c64d400930578924';
