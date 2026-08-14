// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_details_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskHistoryEntries)
const taskHistoryEntriesProvider = TaskHistoryEntriesProvider._();

final class TaskHistoryEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskHistoryEntry>>,
          List<TaskHistoryEntry>,
          FutureOr<List<TaskHistoryEntry>>
        >
    with
        $FutureModifier<List<TaskHistoryEntry>>,
        $FutureProvider<List<TaskHistoryEntry>> {
  const TaskHistoryEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskHistoryEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskHistoryEntriesHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskHistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskHistoryEntry>> create(Ref ref) {
    return taskHistoryEntries(ref);
  }
}

String _$taskHistoryEntriesHash() =>
    r'8c4c02f65b9b15711725996787a409d96645f720';

@ProviderFor(taskHistoryEntriesByTaskId)
const taskHistoryEntriesByTaskIdProvider = TaskHistoryEntriesByTaskIdFamily._();

final class TaskHistoryEntriesByTaskIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskHistoryEntry>>,
          List<TaskHistoryEntry>,
          FutureOr<List<TaskHistoryEntry>>
        >
    with
        $FutureModifier<List<TaskHistoryEntry>>,
        $FutureProvider<List<TaskHistoryEntry>> {
  const TaskHistoryEntriesByTaskIdProvider._({
    required TaskHistoryEntriesByTaskIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taskHistoryEntriesByTaskIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskHistoryEntriesByTaskIdHash();

  @override
  String toString() {
    return r'taskHistoryEntriesByTaskIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TaskHistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskHistoryEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return taskHistoryEntriesByTaskId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskHistoryEntriesByTaskIdProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskHistoryEntriesByTaskIdHash() =>
    r'f12d768ce0c346032bb9bc460a82dbec429e0c22';

final class TaskHistoryEntriesByTaskIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TaskHistoryEntry>>, String> {
  const TaskHistoryEntriesByTaskIdFamily._()
    : super(
        retry: null,
        name: r'taskHistoryEntriesByTaskIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TaskHistoryEntriesByTaskIdProvider call(String taskId) =>
      TaskHistoryEntriesByTaskIdProvider._(argument: taskId, from: this);

  @override
  String toString() => r'taskHistoryEntriesByTaskIdProvider';
}

@ProviderFor(TaskDetailsHistory)
const taskDetailsHistoryProvider = TaskDetailsHistoryProvider._();

final class TaskDetailsHistoryProvider
    extends $NotifierProvider<TaskDetailsHistory, void> {
  const TaskDetailsHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDetailsHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDetailsHistoryHash();

  @$internal
  @override
  TaskDetailsHistory create() => TaskDetailsHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$taskDetailsHistoryHash() =>
    r'd9668f5d04454982a44801096fb2aa6070662d60';

abstract class _$TaskDetailsHistory extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
