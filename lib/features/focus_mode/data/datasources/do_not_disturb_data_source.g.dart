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
          DoNotDisturbDataSourceImpl,
          DoNotDisturbDataSourceImpl,
          DoNotDisturbDataSourceImpl
        >
    with $Provider<DoNotDisturbDataSourceImpl> {
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
  $ProviderElement<DoNotDisturbDataSourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DoNotDisturbDataSourceImpl create(Ref ref) {
    return doNotDisturbDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoNotDisturbDataSourceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoNotDisturbDataSourceImpl>(value),
    );
  }
}

String _$doNotDisturbDataSourceHash() =>
    r'89ce9e675bf3e5cec88b4c719f70d42b9c73bdfa';
