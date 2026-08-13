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
          AsyncValue<TaskDetailsLocalDataSourceImpl>,
          TaskDetailsLocalDataSourceImpl,
          FutureOr<TaskDetailsLocalDataSourceImpl>
        >
    with
        $FutureModifier<TaskDetailsLocalDataSourceImpl>,
        $FutureProvider<TaskDetailsLocalDataSourceImpl> {
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
  $FutureProviderElement<TaskDetailsLocalDataSourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskDetailsLocalDataSourceImpl> create(Ref ref) {
    return taskDetailsLocalDataSource(ref);
  }
}

String _$taskDetailsLocalDataSourceHash() =>
    r'645f89d4f8cb0924a65258b99780ec9ea6fc0a8f';
