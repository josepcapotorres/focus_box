import 'package:do_not_disturb/do_not_disturb.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:focus_box/features/focus_mode/data/datasources/do_not_disturb_data_source.dart';
import 'package:focus_box/features/focus_mode/data/datasources/do_not_disturb_data_source_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockDoNotDisturbPlugin extends Mock implements DoNotDisturbPlugin {}

void main() {
  late MockDoNotDisturbPlugin mockDoNotDisturbPlugin;
  late DoNotDisturbDataSource dataSourceImpl;

  setUp(() {
    mockDoNotDisturbPlugin = MockDoNotDisturbPlugin();
    dataSourceImpl = DoNotDisturbDataSourceImpl(mockDoNotDisturbPlugin);
  });

  group("isDndEnabled", () {
    test(
      "should isDndEnabled return true if Dnd is enabled currently",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isDndEnabled(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await dataSourceImpl.isDndEnabled;

        // Assert
        verify(() => mockDoNotDisturbPlugin.isDndEnabled()).called(1);
        expect(result, isTrue);
      },
    );

    test(
      "should isDndEnabled return false if Dnd is disabled currently",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isDndEnabled(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await dataSourceImpl.isDndEnabled;

        // Assert
        verify(() => mockDoNotDisturbPlugin.isDndEnabled()).called(1);
        expect(result, isFalse);
      },
    );
  });

  group("enableDNDMode", () {
    test(
      "should enableDNDMode return false if policy access is not granted by user",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).thenAnswer((_) async => false);

        when(
          () => mockDoNotDisturbPlugin.openNotificationPolicyAccessSettings(),
        ).thenAnswer((_) async {});

        // Act
        final result = await dataSourceImpl.enableDNDMode();

        // Assert
        verify(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).called(1);
        expect(result, isFalse);
      },
    );

    test(
      "should enableDNDMode return true if policy access is granted by user and DnD is enabled",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).thenAnswer((_) async => true);

        when(
          () => mockDoNotDisturbPlugin.isDndEnabled(),
        ).thenAnswer((_) async => true);
        when(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.priority),
        ).thenAnswer((_) async {});

        // Act
        final result = await dataSourceImpl.enableDNDMode();

        // Assert
        verify(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).called(1);
        verify(() => mockDoNotDisturbPlugin.isDndEnabled()).called(1);
        verify(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.priority),
        ).called(1);
        verifyNever(() => mockDoNotDisturbPlugin.openDndSettings());

        expect(result, isTrue);
      },
    );

    test(
      "should enableDNDMode return true if policy access is granted by user and DnD is disabled",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).thenAnswer((_) async => true);

        when(
          () => mockDoNotDisturbPlugin.isDndEnabled(),
        ).thenAnswer((_) async => false);
        when(
          () => mockDoNotDisturbPlugin.openDndSettings(),
        ).thenAnswer((_) async {});

        // Act
        final result = await dataSourceImpl.enableDNDMode();

        // Assert
        verify(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).called(1);
        verify(() => mockDoNotDisturbPlugin.isDndEnabled()).called(1);
        verify(() => mockDoNotDisturbPlugin.openDndSettings()).called(1);
        verifyNever(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.priority),
        );
        expect(result, isFalse);
      },
    );
  });

  group("disableDNDMode", () {
    test(
      "should return true is notification policy is granted and disable all interruption filters",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).thenAnswer((_) async => true);
        when(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.all),
        ).thenAnswer((_) async {});

        // Act
        final result = await dataSourceImpl.disableDNDMode();

        // Assert
        verify(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).called(1);
        verify(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.all),
        ).called(1);

        expect(result, isTrue);
      },
    );

    test(
      "should return true is notification policy is not granted at first but granted after having asked again",
      () async {
        int calls = 0;
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).thenAnswer((_) async {
          calls++;
          // We want the first time we call this method to return a false
          // and the second time, return a true
          return calls == 1 ? false : true;
        });

        when(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.all),
        ).thenAnswer((_) async {});

        // Act
        final result = await dataSourceImpl.disableDNDMode();

        // Assert
        verify(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).called(2);
        verify(
          () => mockDoNotDisturbPlugin.setInterruptionFilter(.all),
        ).called(1);

        verifyNever(
          () => mockDoNotDisturbPlugin.openNotificationPolicyAccessSettings(),
        );

        expect(result, isTrue);
      },
    );

    test(
      "should return false is notification policy is not granted in any of the two opportunities that the user has",
      () async {
        // Arrange
        when(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).thenAnswer((_) async => false);

        when(
          () => mockDoNotDisturbPlugin.openNotificationPolicyAccessSettings(),
        ).thenAnswer((_) async {});

        // Act
        final result = await dataSourceImpl.disableDNDMode();

        // Assert
        verify(
          () => mockDoNotDisturbPlugin.isNotificationPolicyAccessGranted(),
        ).called(2);
        verify(
          () => mockDoNotDisturbPlugin.openNotificationPolicyAccessSettings(),
        ).called(1);

        verifyNever(() => mockDoNotDisturbPlugin.setInterruptionFilter(.all));

        expect(result, isFalse);
      },
    );
  });
}
