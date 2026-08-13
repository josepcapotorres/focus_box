// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'do_not_disturb_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(doNotDisturbRepository)
const doNotDisturbRepositoryProvider = DoNotDisturbRepositoryProvider._();

final class DoNotDisturbRepositoryProvider
    extends
        $FunctionalProvider<
          DoNotDisturbRepository,
          DoNotDisturbRepository,
          DoNotDisturbRepository
        >
    with $Provider<DoNotDisturbRepository> {
  const DoNotDisturbRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doNotDisturbRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doNotDisturbRepositoryHash();

  @$internal
  @override
  $ProviderElement<DoNotDisturbRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DoNotDisturbRepository create(Ref ref) {
    return doNotDisturbRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoNotDisturbRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoNotDisturbRepository>(value),
    );
  }
}

String _$doNotDisturbRepositoryHash() =>
    r'59838cfabc10f98d7fda953107e8f894b9de606b';
