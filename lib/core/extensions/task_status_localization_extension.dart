import 'package:focus_box/core/domain/enums/task_status.dart';
import 'package:focus_box/core/l10n/app_localizations.dart';

extension TaskStatusLocalizationExtension on TaskStatus {
  String label(AppLocalizations l10n) {
    return switch (this) {
      TaskStatus.inProgress => l10n.commonTaskInProgress,
      TaskStatus.completed => l10n.commonTaskCompleted,
      TaskStatus.paused => l10n.commonTaskPaused,
      TaskStatus.exceeded => l10n.commonTaskExceeded,
      TaskStatus.pending => l10n.commonTaskPending,
    };
  }
}
