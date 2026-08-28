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
          AsyncValue<TaskDetailsRepository>,
          TaskDetailsRepository,
          FutureOr<TaskDetailsRepository>
        >
    with
        $FutureModifier<TaskDetailsRepository>,
        $FutureProvider<TaskDetailsRepository> {
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
  $FutureProviderElement<TaskDetailsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskDetailsRepository> create(Ref ref) {
    return taskDetailsRepository(ref);
  }
}

String _$taskDetailsRepositoryHash() =>
    r'9b1544e918e728e06659bbbee7127eaae154c3a9';
