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

@ProviderFor(taskDetailsHistoryAddEntry)
const taskDetailsHistoryAddEntryProvider = TaskDetailsHistoryAddEntryFamily._();

final class TaskDetailsHistoryAddEntryProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const TaskDetailsHistoryAddEntryProvider._({
    required TaskDetailsHistoryAddEntryFamily super.from,
    required TaskHistoryEntry super.argument,
  }) : super(
         retry: null,
         name: r'taskDetailsHistoryAddEntryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskDetailsHistoryAddEntryHash();

  @override
  String toString() {
    return r'taskDetailsHistoryAddEntryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as TaskHistoryEntry;
    return taskDetailsHistoryAddEntry(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskDetailsHistoryAddEntryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskDetailsHistoryAddEntryHash() =>
    r'089dd580609d9bf171900eb3a1e31a18b7f872e1';

final class TaskDetailsHistoryAddEntryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, TaskHistoryEntry> {
  const TaskDetailsHistoryAddEntryFamily._()
    : super(
        retry: null,
        name: r'taskDetailsHistoryAddEntryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TaskDetailsHistoryAddEntryProvider call(TaskHistoryEntry entry) =>
      TaskDetailsHistoryAddEntryProvider._(argument: entry, from: this);

  @override
  String toString() => r'taskDetailsHistoryAddEntryProvider';
}
