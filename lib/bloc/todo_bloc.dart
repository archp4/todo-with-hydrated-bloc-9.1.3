import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/todo.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeteleTodo);
    on<MarkDoneTodo>(_onMarkDoneTodo);
  }

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toMap();
  }

  void _onStarted(
    TodoStarted event,
    Emitter<TodoState> emit,
  ) {
    if (state.status == TodoStatus.success) return;
    emit(
      state.copyWith(
        todos: state.todos,
        status: TodoStatus.success,
      ),
    );
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      List<TodoModel> temp = [];
      if (state.todos.isNotEmpty) temp.addAll(state.todos);
      if (state.todos.isNotEmpty) temp.insert(0, event.todo);
      if (!state.todos.isNotEmpty) temp.add(event.todo);
      emit(state.copyWith(todos: temp, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onDeteleTodo(
    DeleteTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      state.todos.remove(event.todo);
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }

  void _onMarkDoneTodo(
    MarkDoneTodo event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      state.todos[event.index].isDone = !state.todos[event.index].isDone;
      emit(state.copyWith(todos: state.todos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error));
    }
  }
}
