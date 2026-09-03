import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_box/core/extensions/translations_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../features/home/domain/repositories/home_repository.dart';
import '../domain/entities/task.dart';
import '../managers/crash_reporter.dart';

class NewTaskEditBottomSheet extends StatefulWidget {
  final Task? task;

  const NewTaskEditBottomSheet({super.key, this.task});

  @override
  State<NewTaskEditBottomSheet> createState() => _NewTaskEditBottomSheetState();
}

class _NewTaskEditBottomSheetState extends State<NewTaskEditBottomSheet> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _taskNameController;
  late TextEditingController _timeTotalHoursController;
  late TextEditingController _timeTotalMinutesController;
  late TextEditingController _dayToDoTaskController;
  DateTime? _dayToDoTask;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey();

    final duration = widget.task?.timeTotal;

    _taskNameController = TextEditingController(text: widget.task?.name);
    _timeTotalHoursController = TextEditingController(
      text: duration?.inHours.toString(),
    );

    _timeTotalMinutesController = TextEditingController(
      text: duration != null ? (duration.inMinutes % 60).toString() : null,
    );

    _dayToDoTaskController = TextEditingController();
    _setDayToDoTaskText(widget.task?.day ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat("d 'de' MMMM");

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Align(
                  alignment: .center,
                  child: Text(
                    widget.task != null
                        ? context.l10n.saveEditTaskEditTaskTitle
                        : context.l10n.saveEditTaskNewTaskTitle,
                    style: textTheme.headlineMedium,
                  ),
                ),
              ),
              Text(
                context.l10n.saveEditTaskTaskName,
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key("taskNameField"),
                controller: _taskNameController,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.task)),
                textCapitalization: .sentences,
                textInputAction: .next,
                validator: (str) {
                  if (str?.isEmpty ?? false) return "Rellene este campo";
                  return null;
                },
                autofocus: true,
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.saveEditTaskTimeEstimated,
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Row(
                spacing: 16,
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      key: const Key("timeTotalHsField"),
                      controller: _timeTotalHoursController,
                      decoration: const InputDecoration(
                        // Hide error message height
                        errorStyle: TextStyle(height: 0),
                      ),
                      keyboardType: .number,
                      validator: (str) =>
                          int.tryParse(str ?? "") == null ? "" : null,
                      textInputAction: .next,
                    ),
                  ),
                  const Text("h"),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      key: const Key("timeTotalMinsField"),
                      controller: _timeTotalMinutesController,
                      decoration: const InputDecoration(
                        // Hide error message height
                        errorStyle: TextStyle(height: 0),
                      ),
                      validator: (str) =>
                          int.tryParse(str ?? "") == null ? "" : null,
                      textInputAction: .next,
                      keyboardType: .number,
                    ),
                  ),
                  const Text("min"),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.saveEditTaskAssignDay,
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key("dayToDoTaskField"),
                controller: _dayToDoTaskController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.event),
                  hint: Text(
                    dateFormat.format(widget.task?.day ?? DateTime.now()),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.task?.day ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 14)),
                  );

                  if (selectedDate == null) return;

                  _dayToDoTask = selectedDate;
                  _setDayToDoTaskText(_dayToDoTask!);
                },
                validator: (str) {
                  if (str?.isEmpty ?? false) return "Rellene este campo";
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SafeArea(
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: context.pop,
                        child: Text(context.l10n.commonCancel),
                      ),
                    ),
                    Expanded(
                      child: Consumer(
                        builder: (_, ref, _) => FilledButton(
                          key: const Key("newTaskSaveBtn"),
                          onPressed: () async {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              return;
                            }

                            _formKey.currentState?.save();

                            context.pop();

                            final newTaskValues = _updateTaskValues();

                            final homeRepository = await ref.read(
                              homeRepositoryProvider.future,
                            );

                            try {
                              await homeRepository.saveOrEditTask(
                                newTaskValues,
                              );
                            } catch (e, s) {
                              ref.read(crashReporterProvider).recordError(e, s);
                            }
                          },
                          child: Text(context.l10n.commonSave),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Task _updateTaskValues() {
    return Task(
      widget.task?.id ?? const Uuid().v4(),
      _taskNameController.text,
      .pending,
      widget.task?.timeAlreadyDone ?? Duration.zero,
      Duration(
        hours: int.tryParse(_timeTotalHoursController.text) ?? 0,
        minutes: int.tryParse(_timeTotalMinutesController.text) ?? 0,
      ),
      _dayToDoTask ?? DateTime.now(),
      null,
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _timeTotalHoursController.dispose();
    _timeTotalMinutesController.dispose();
    _dayToDoTaskController.dispose();

    super.dispose();
  }

  void _setDayToDoTaskText(DateTime dateTime) {
    _dayToDoTaskController.text = DateFormat("dd/MM/yyyy").format(dateTime);
  }
}
