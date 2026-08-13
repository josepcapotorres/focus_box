// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_details_current_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskDetailsCurrentFilter)
const taskDetailsCurrentFilterProvider = TaskDetailsCurrentFilterProvider._();

final class TaskDetailsCurrentFilterProvider
    extends $NotifierProvider<TaskDetailsCurrentFilter, TaskFilterEnum> {
  const TaskDetailsCurrentFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDetailsCurrentFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDetailsCurrentFilterHash();

  @$internal
  @override
  TaskDetailsCurrentFilter create() => TaskDetailsCurrentFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskFilterEnum value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskFilterEnum>(value),
    );
  }
}

String _$taskDetailsCurrentFilterHash() =>
    r'7e54c0ce15a01f997ddbe9150504a1dba8a01512';

abstract class _$TaskDetailsCurrentFilter extends $Notifier<TaskFilterEnum> {
  TaskFilterEnum build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TaskFilterEnum, TaskFilterEnum>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TaskFilterEnum, TaskFilterEnum>,
              TaskFilterEnum,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
