// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  final List<TodoModel> todos;
  final TodoStatus status;

  const TodoState({
    this.todos = const <TodoModel>[],
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    List<TodoModel>? todos,
    TodoStatus? status,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [todos, status];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todos': todos.map((x) => x.toJson()).toList(),
      'status': status.toString(),
    };
  }

  factory TodoState.fromMap(Map<String, dynamic> map) {
    return TodoState(
      todos: List<TodoModel>.from(
        (map['todos'] as List<int>).map<TodoModel>(
          (x) => TodoModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      status: TodoStatus.values
          .firstWhere((element) => element.name.toString() == map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoState.fromJson(String source) =>
      TodoState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
