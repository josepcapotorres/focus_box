// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_details_local_data_source_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskDetailsLocalDataSource)
const taskDetailsLocalDataSourceProvider =
    TaskDetailsLocalDataSourceProvider._();

final class TaskDetailsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<TaskDetailsLocalDataSource>,
          TaskDetailsLocalDataSource,
          FutureOr<TaskDetailsLocalDataSource>
        >
    with
        $FutureModifier<TaskDetailsLocalDataSource>,
        $FutureProvider<TaskDetailsLocalDataSource> {
  const TaskDetailsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDetailsLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDetailsLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<TaskDetailsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskDetailsLocalDataSource> create(Ref ref) {
    return taskDetailsLocalDataSource(ref);
  }
}

String _$taskDetailsLocalDataSourceHash() =>
    r'70f334b276038c3d5244922a6fb8ee723edcfed3';
