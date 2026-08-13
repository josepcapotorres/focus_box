// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeLocalDataSource)
const homeLocalDataSourceProvider = HomeLocalDataSourceProvider._();

final class HomeLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeLocalDataSource>,
          HomeLocalDataSource,
          FutureOr<HomeLocalDataSource>
        >
    with
        $FutureModifier<HomeLocalDataSource>,
        $FutureProvider<HomeLocalDataSource> {
  const HomeLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<HomeLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HomeLocalDataSource> create(Ref ref) {
    return homeLocalDataSource(ref);
  }
}

String _$homeLocalDataSourceHash() =>
    r'51cc616fdf8e3e362c93416bb476c16be80aeca2';
