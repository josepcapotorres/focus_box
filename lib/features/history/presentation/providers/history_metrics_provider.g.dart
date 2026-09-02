// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_metrics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(historyMetrics)
const historyMetricsProvider = HistoryMetricsProvider._();

final class HistoryMetricsProvider
    extends
        $FunctionalProvider<
          AsyncValue<HistoryMetric>,
          HistoryMetric,
          FutureOr<HistoryMetric>
        >
    with $FutureModifier<HistoryMetric>, $FutureProvider<HistoryMetric> {
  const HistoryMetricsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyMetricsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyMetricsHash();

  @$internal
  @override
  $FutureProviderElement<HistoryMetric> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HistoryMetric> create(Ref ref) {
    return historyMetrics(ref);
  }
}

String _$historyMetricsHash() => r'914eec67312a73392f720b66291d448f0f47f3ad';

@ProviderFor(historyTasksBetweenSelectedDateRange)
const historyTasksBetweenSelectedDateRangeProvider =
    HistoryTasksBetweenSelectedDateRangeProvider._();

final class HistoryTasksBetweenSelectedDateRangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Task>>,
          List<Task>,
          FutureOr<List<Task>>
        >
    with $FutureModifier<List<Task>>, $FutureProvider<List<Task>> {
  const HistoryTasksBetweenSelectedDateRangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyTasksBetweenSelectedDateRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$historyTasksBetweenSelectedDateRangeHash();

  @$internal
  @override
  $FutureProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Task>> create(Ref ref) {
    return historyTasksBetweenSelectedDateRange(ref);
  }
}

String _$historyTasksBetweenSelectedDateRangeHash() =>
    r'f64c04a6dc0f81a6ab4ee464df8967e71a2c6b0e';

@ProviderFor(historyEntriesBetweenSelectedDateRange)
const historyEntriesBetweenSelectedDateRangeProvider =
    HistoryEntriesBetweenSelectedDateRangeProvider._();

final class HistoryEntriesBetweenSelectedDateRangeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskHistoryEntry>>,
          List<TaskHistoryEntry>,
          FutureOr<List<TaskHistoryEntry>>
        >
    with
        $FutureModifier<List<TaskHistoryEntry>>,
        $FutureProvider<List<TaskHistoryEntry>> {
  const HistoryEntriesBetweenSelectedDateRangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyEntriesBetweenSelectedDateRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$historyEntriesBetweenSelectedDateRangeHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskHistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskHistoryEntry>> create(Ref ref) {
    return historyEntriesBetweenSelectedDateRange(ref);
  }
}

String _$historyEntriesBetweenSelectedDateRangeHash() =>
    r'f6d661c727c807a6dc3eec9f7ff39b93e3fa4a96';
