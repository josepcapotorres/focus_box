// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeTasks)
const homeTasksProvider = HomeTasksProvider._();

final class HomeTasksProvider
    extends $StreamNotifierProvider<HomeTasks, List<Task>> {
  const HomeTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeTasksHash();

  @$internal
  @override
  HomeTasks create() => HomeTasks();
}

String _$homeTasksHash() => r'35b8f1f79188935dcdfb4843a53fa414e0ba2c99';

abstract class _$HomeTasks extends $StreamNotifier<List<Task>> {
  Stream<List<Task>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Task>>, List<Task>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Task>>, List<Task>>,
              AsyncValue<List<Task>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(currentTask)
const currentTaskProvider = CurrentTaskFamily._();

final class CurrentTaskProvider extends $FunctionalProvider<Task?, Task?, Task?>
    with $Provider<Task?> {
  const CurrentTaskProvider._({
    required CurrentTaskFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'currentTaskProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentTaskHash();

  @override
  String toString() {
    return r'currentTaskProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Task?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Task? create(Ref ref) {
    final argument = this.argument as String?;
    return currentTask(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Task? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Task?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentTaskProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentTaskHash() => r'bbe7cc8a1e7f6cd4fae49c82551238a4ae35495f';

final class CurrentTaskFamily extends $Family
    with $FunctionalFamilyOverride<Task?, String?> {
  const CurrentTaskFamily._()
    : super(
        retry: null,
        name: r'currentTaskProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentTaskProvider call(String? taskId) =>
      CurrentTaskProvider._(argument: taskId, from: this);

  @override
  String toString() => r'currentTaskProvider';
}

@ProviderFor(homeFilteredTasks)
const homeFilteredTasksProvider = HomeFilteredTasksProvider._();

final class HomeFilteredTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Task>>,
          List<Task>,
          FutureOr<List<Task>>
        >
    with $FutureModifier<List<Task>>, $FutureProvider<List<Task>> {
  const HomeFilteredTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeFilteredTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeFilteredTasksHash();

  @$internal
  @override
  $FutureProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Task>> create(Ref ref) {
    return homeFilteredTasks(ref);
  }
}

String _$homeFilteredTasksHash() => r'8a602c0ae75a7d436fac57568cce03b2655d0cab';

@ProviderFor(recoverInterruptedSession)
const recoverInterruptedSessionProvider = RecoverInterruptedSessionProvider._();

final class RecoverInterruptedSessionProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const RecoverInterruptedSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recoverInterruptedSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recoverInterruptedSessionHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return recoverInterruptedSession(ref);
  }
}

String _$recoverInterruptedSessionHash() =>
    r'5315adad9e4aa6dc8a117b5d083c67a4f95c0c9c';
