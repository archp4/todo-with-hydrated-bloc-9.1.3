part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodo extends TodoEvent {
  final TodoModel todo;
  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final TodoModel todo;
  const DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class MarkDoneTodo extends TodoEvent {
  final int index;
  const MarkDoneTodo(this.index);

  @override
  List<Object> get props => [index];
}
