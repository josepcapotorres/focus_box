// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_selected_date_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeSelectedDateFilter)
const homeSelectedDateFilterProvider = HomeSelectedDateFilterProvider._();

final class HomeSelectedDateFilterProvider
    extends $NotifierProvider<HomeSelectedDateFilter, DateTime> {
  const HomeSelectedDateFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSelectedDateFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSelectedDateFilterHash();

  @$internal
  @override
  HomeSelectedDateFilter create() => HomeSelectedDateFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$homeSelectedDateFilterHash() =>
    r'334485a4949b31e60bb1763e1e0e1a2d8a7c9b03';

abstract class _$HomeSelectedDateFilter extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
