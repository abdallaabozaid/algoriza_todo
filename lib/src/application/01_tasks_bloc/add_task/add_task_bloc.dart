import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/config/enums.dart';
import 'package:todo_app/src/domain/01_tasks/i_tasks_repo.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';
import 'package:todo_app/src/domain/01_tasks/value_failures.dart';
import 'package:todo_app/src/domain/01_tasks/value_objects.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final ITasksRepo _tasksRepo;
  AddTaskBloc(this._tasksRepo) : super(AddTaskState.initial()) {
    on<AdddTaskEvent>(_onAddTaskEvent);
    on<TaskTitleChangedEvent>(_onTaskTitleChangedEvent);
    on<DateChangedEvent>(_onDateChangedEvent);
    on<StartTimeChangedEvent>(_onStartTimeChangedEvent);
    on<EndTimeChangedEvent>(_onEndTimeChangedEvent);
    on<RemindChangedEvent>(_onRemindChangedEvent);
    on<RepeatChangedEvent>(_onRepeatChangedEvent);
    on<PriorityChangedEvent>(_onPriorityChangedEvent);
  }

  FutureOr<void> _onAddTaskEvent(
      AdddTaskEvent event, Emitter<AddTaskState> emit) async {
    if (state.addedTask.title.isValid()) {
      emit(
        state.copyWith(
          isLoading: true,
          showErrors: false,
          addingSuccessOrFailureOption: none(),
        ),
      );
      final newTaskId = Random().nextInt(99999);

      final suceessOrFailure = await _tasksRepo.addTask(
          addedTask: state.addedTask.copyWith(
        id: newTaskId,
      ));

      emit(
        state.copyWith(
          addedTask: state.addedTask.copyWith(
            id: newTaskId,
          ),
          isLoading: false,
          addingSuccessOrFailureOption: some(suceessOrFailure),
        ),
      );
    } else {
      emit(
        state.copyWith(
          showErrors: true,
          addingSuccessOrFailureOption: none(),
        ),
      );
    }
  }

  FutureOr<void> _onTaskTitleChangedEvent(
      TaskTitleChangedEvent event, Emitter<AddTaskState> emit) {
    emit(
      state.copyWith(
        addedTask: state.addedTask.copyWith(
          title: TaskTitle(event.title),
        ),
        addingSuccessOrFailureOption: none(),
      ),
    );
  }

  FutureOr<void> _onDateChangedEvent(
      DateChangedEvent event, Emitter<AddTaskState> emit) {
    emit(
      state.copyWith(
        addedTask: state.addedTask.copyWith(
          date: TaskDate(date: event.date),
        ),
        addingSuccessOrFailureOption: none(),
      ),
    );
  }

  FutureOr<void> _onStartTimeChangedEvent(
      StartTimeChangedEvent event, Emitter<AddTaskState> emit) {
    final bool timesInSamePeriodOfDay =
        event.startTime.period == state.addedTask.endTime.timeOfDay.period;

    if (timesInSamePeriodOfDay) {
      // the 2 times at same periods of day >>
      final bool startTimeBeforeEndTime = _toDouble(event.startTime) <=
          _toDouble(state.addedTask.endTime.timeOfDay);

      if (startTimeBeforeEndTime) {
        // start time before end time >> normal case
        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
                startTime: TaskStartTime.fromTimeOfDay(time: event.startTime)),
            addingSuccessOrFailureOption: none(),
            timeFailure: none(),
          ),
        );
      } else {
        // start time after end time >> abnormal case

        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
              startTime: TaskStartTime.fromTimeOfDay(
                time: event.startTime,
              ),
              endTime: TaskEndTime.fromTimeOfDay(time: event.startTime),
            ),
            addingSuccessOrFailureOption: none(),
            timeFailure: some(
              ChooseTimeFailure(
                failedValue: 'Start must be before End time',
              ),
            ),
          ),
        );
      }
    } else {
      // the 2 times at different periods of day >>

      if (event.startTime.period == DayPeriod.am &&
          state.addedTask.endTime.timeOfDay.period == DayPeriod.pm) {
        // start time is am which is before end time >> normal case

        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
                startTime: TaskStartTime.fromTimeOfDay(time: event.startTime)),
            addingSuccessOrFailureOption: none(),
            timeFailure: none(),
          ),
        );
      } else {
        // start time is pm which is after end time >> abnormal case

        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
              startTime: TaskStartTime.fromTimeOfDay(
                time: event.startTime,
              ),
              endTime: TaskEndTime.fromTimeOfDay(time: event.startTime),
            ),
            addingSuccessOrFailureOption: none(),
            timeFailure: some(
              ChooseTimeFailure(
                failedValue: 'Start must be before End time',
              ),
            ),
          ),
        );
      }
    }
  }

  FutureOr<void> _onEndTimeChangedEvent(
      EndTimeChangedEvent event, Emitter<AddTaskState> emit) {
    final bool timesInSamePeriodOfDay =
        event.endTime.period == state.addedTask.startTime.timeOfDay.period;

    if (timesInSamePeriodOfDay) {
      // the 2 times at same periods of day >>

      final bool startTimeBeforeEndTime = _toDouble(event.endTime) >=
          _toDouble(state.addedTask.startTime.timeOfDay);

      if (startTimeBeforeEndTime) {
        // start time before end time >> normal case
        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
                endTime: TaskEndTime.fromTimeOfDay(time: event.endTime)),
            addingSuccessOrFailureOption: none(),
            timeFailure: none(),
          ),
        );
      } else {
        // start time after end time >> abnormal case

        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
              endTime: TaskEndTime.fromTimeOfDay(
                time: state.addedTask.startTime.timeOfDay,
              ),
            ),
            addingSuccessOrFailureOption: none(),
            timeFailure: some(
              ChooseTimeFailure(
                failedValue: 'End time must be after Start time',
              ),
            ),
          ),
        );
      }
    } else {
      // the 2 times at different periods of day >>

      if (event.endTime.period == DayPeriod.pm &&
          state.addedTask.startTime.timeOfDay.period == DayPeriod.am) {
        // start time is am which is before end time >> normal case

        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
              endTime: TaskEndTime.fromTimeOfDay(
                time: event.endTime,
              ),
            ),
            addingSuccessOrFailureOption: none(),
            timeFailure: none(),
          ),
        );
      } else {
        // start time is pm which is after end time >> abnormal case

        emit(
          state.copyWith(
            addedTask: state.addedTask.copyWith(
              endTime: TaskEndTime.fromTimeOfDay(
                time: state.addedTask.startTime.timeOfDay,
              ),
            ),
            addingSuccessOrFailureOption: none(),
            timeFailure: some(
              ChooseTimeFailure(
                failedValue: 'End time must be after Start time',
              ),
            ),
          ),
        );
      }
    }
  }

  double _toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  FutureOr<void> _onRemindChangedEvent(
      RemindChangedEvent event, Emitter<AddTaskState> emit) {
    emit(
      state.copyWith(
        addedTask: state.addedTask
            .copyWith(reminder: Reminder(reminderType: event.type)),
        addingSuccessOrFailureOption: none(),
      ),
    );
  }

  FutureOr<void> _onRepeatChangedEvent(
      RepeatChangedEvent event, Emitter<AddTaskState> emit) {
    emit(
      state.copyWith(
        addedTask:
            state.addedTask.copyWith(repeat: Repeat(repeatType: event.type)),
        addingSuccessOrFailureOption: none(),
      ),
    );
  }

  FutureOr<void> _onPriorityChangedEvent(
      PriorityChangedEvent event, Emitter<AddTaskState> emit) {
    emit(
      state.copyWith(
        addedTask: state.addedTask.copyWith(
          priorityColor: PriorityColor(
            priority: event.type,
          ),
        ),
        addingSuccessOrFailureOption: none(),
      ),
    );
  }
}
