// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_details_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskDetailsRepository)
const taskDetailsRepositoryProvider = TaskDetailsRepositoryProvider._();

final class TaskDetailsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TaskDetailsRepositoryImpl>,
          TaskDetailsRepositoryImpl,
          FutureOr<TaskDetailsRepositoryImpl>
        >
    with
        $FutureModifier<TaskDetailsRepositoryImpl>,
        $FutureProvider<TaskDetailsRepositoryImpl> {
  const TaskDetailsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDetailsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDetailsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<TaskDetailsRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskDetailsRepositoryImpl> create(Ref ref) {
    return taskDetailsRepository(ref);
  }
}

String _$taskDetailsRepositoryHash() =>
    r'6ecd90e38a0f288f43e272fb1265ff4b83c152bd';
