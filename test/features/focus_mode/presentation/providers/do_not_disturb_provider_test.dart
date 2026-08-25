import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/features/focus_mode/domain/repositories/do_not_disturb_repository.dart';
import 'package:focus_box/features/focus_mode/presentation/providers/do_not_disturb_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockDndRepository extends Mock implements DoNotDisturbRepository {}

void main() {
  late MockDndRepository mockDndRepository;
  late ProviderContainer container;

  setUp(() {
    mockDndRepository = MockDndRepository();

    container = ProviderContainer(
      overrides: [
        doNotDisturbRepositoryProvider.overrideWithValue(mockDndRepository),
      ],
    );
  });

  test("should be disabled by default", () async {
    // Arrange
    when(() => mockDndRepository.isDndEnabled).thenAnswer((_) async => false);

    // Act
    final dndEnabled = await container.read(doNotDisturbProvider.future);

    // Assert
    verify(() => mockDndRepository.isDndEnabled).called(1);
    expect(dndEnabled, isFalse);
  });

  group("enableDNDMode", () {
    test("should enable the dnd mode successfully", () async {
      // Arrange
      when(
        () => mockDndRepository.enableDNDMode(),
      ).thenAnswer((_) async => true);

      // Act
      await container.read(doNotDisturbProvider.notifier).enableDNDMode();

      // Assert
      verify(() => mockDndRepository.enableDNDMode()).called(1);
      expect(container.read(doNotDisturbProvider).value, isTrue);
    });

    test("should return false on trying to enable dnd mode", () async {
      // Arrange
      when(
        () => mockDndRepository.enableDNDMode(),
      ).thenAnswer((_) async => false);

      // Act
      await container.read(doNotDisturbProvider.notifier).enableDNDMode();

      // Assert
      verify(() => mockDndRepository.enableDNDMode()).called(1);
      expect(container.read(doNotDisturbProvider).value, isFalse);
    });
  });

  group("disableDNDMode", () {
    test("should disable the DND mode successfully", () async {
      // Arrange
      when(
        () => mockDndRepository.disableDNDMode(),
        // True cause it's called successfully
      ).thenAnswer((_) async => true);

      // Act
      await container.read(doNotDisturbProvider.notifier).disableDNDMode();

      // Assert
      verify(() => mockDndRepository.disableDNDMode()).called(1);
      // state = false cause it's already disabled
      expect(container.read(doNotDisturbProvider).value, isFalse);
    });

    test("should return false on trying to disable DND mode", () async {
      // Arrange
      when(
        () => mockDndRepository.disableDNDMode(),
      ).thenAnswer((_) async => false);

      // Act
      final result = await container
          .read(doNotDisturbRepositoryProvider)
          .disableDNDMode();

      // Assert
      verify(() => mockDndRepository.disableDNDMode()).called(1);
      expect(result, isFalse);
    });
  });

  group("refresh", () {
    test(
      "should refresh the data if dnd was disabled so far and now it's enabled. state needs to be updated",
      () async {
        // At first
        when(
          () => mockDndRepository.isDndEnabled,
        ).thenAnswer((_) async => false);

        final prevValueState = await container.read(
          doNotDisturbProvider.future,
        );
        expect(prevValueState, isFalse);

        // When the user resumes the app after having activated DND mode
        // Update provider state
        when(
          () => mockDndRepository.isDndEnabled,
        ).thenAnswer((_) async => true);

        await container.read(doNotDisturbProvider.notifier).refresh();

        expect(container.read(doNotDisturbProvider).value, isTrue);
      },
    );
  });
}
