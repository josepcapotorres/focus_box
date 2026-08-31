// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'do_not_disturb_data_source_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(doNotDisturbDataSource)
const doNotDisturbDataSourceProvider = DoNotDisturbDataSourceProvider._();

final class DoNotDisturbDataSourceProvider
    extends
        $FunctionalProvider<
          DoNotDisturbDataSource,
          DoNotDisturbDataSource,
          DoNotDisturbDataSource
        >
    with $Provider<DoNotDisturbDataSource> {
  const DoNotDisturbDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doNotDisturbDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doNotDisturbDataSourceHash();

  @$internal
  @override
  $ProviderElement<DoNotDisturbDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DoNotDisturbDataSource create(Ref ref) {
    return doNotDisturbDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoNotDisturbDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoNotDisturbDataSource>(value),
    );
  }
}

String _$doNotDisturbDataSourceHash() =>
    r'b08d6361b3353bee88cb1009445595ef2d794b27';
