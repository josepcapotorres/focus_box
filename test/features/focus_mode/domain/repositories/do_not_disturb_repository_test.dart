import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/features/focus_mode/data/datasources/do_not_disturb_data_source.dart';
import 'package:focus_box/features/focus_mode/domain/repositories/do_not_disturb_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDoNotDisturbDataSource extends Mock
    implements DoNotDisturbDataSource {}

void main() {
  late MockDoNotDisturbDataSource mockDataSource;
  late DoNotDisturbRepository repository;

  setUp(() {
    mockDataSource = MockDoNotDisturbDataSource();
    repository = DoNotDisturbRepository(mockDataSource);
  });

  group("isDndEnabled", () {
    test(
      "should isDndEnabled return true if the user has enabled it previously",
      () async {
        // Arrange
        when(() => mockDataSource.isDndEnabled).thenAnswer((_) async => true);

        // Act
        final result = await repository.isDndEnabled;

        // Assert
        verify(() => mockDataSource.isDndEnabled).called(1);
        expect(result, isTrue);
      },
    );

    test(
      "should isDndEnabled return false if dnd is currently disabled",
      () async {
        // Arrange
        when(() => mockDataSource.isDndEnabled).thenAnswer((_) async => false);

        // Act
        final result = await repository.isDndEnabled;

        // Assert
        verify(() => mockDataSource.isDndEnabled).called(1);
        expect(result, isFalse);
      },
    );
  });

  group("enableDNDMode", () {
    test("should return true if dnd has been enabled successfully", () async {
      // Arrange
      when(() => mockDataSource.enableDNDMode()).thenAnswer((_) async => true);

      // Act
      final result = await repository.enableDNDMode();

      // Assert
      verify(() => mockDataSource.enableDNDMode()).called(1);
      expect(result, isTrue);
    });

    test(
      "should return false if there has been any problem on enabling it",
      () async {
        // Arrange
        when(
          () => mockDataSource.enableDNDMode(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await repository.enableDNDMode();

        // Assert
        verify(() => mockDataSource.enableDNDMode()).called(1);
        expect(result, isFalse);
      },
    );
  });

  group("disableDNDMode", () {
    test("should return true if dnd has been disabled successfully", () async {
      // Arrange
      when(() => mockDataSource.disableDNDMode()).thenAnswer((_) async => true);

      // Act
      final result = await repository.disableDNDMode();

      // Assert
      verify(() => mockDataSource.disableDNDMode()).called(1);
      expect(result, isTrue);
    });

    test(
      "should return false if there has been any problem on disabling it",
      () async {
        // Arrange
        when(
          () => mockDataSource.disableDNDMode(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await repository.disableDNDMode();

        // Assert
        verify(() => mockDataSource.disableDNDMode()).called(1);
        expect(result, isFalse);
      },
    );
  });
}
