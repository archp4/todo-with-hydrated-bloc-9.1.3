import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_with_local_storage_and_bloc/bloc/todo_bloc.dart';
import 'package:todo_with_local_storage_and_bloc/models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addTodo({required TodoModel todo}) {
    context.read<TodoBloc>().add(AddTodo(todo));
  }

  deleteTodo({required TodoModel todo}) {
    context.read<TodoBloc>().add(DeleteTodo(todo));
  }

  markDoneTodo({required int index}) {
    context.read<TodoBloc>().add(MarkDoneTodo(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          "My Todo App",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.status == TodoStatus.success) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              deleteTodo(todo: state.todos[index]);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text(state.todos[index].title),
                        subtitle: Text(state.todos[index].subtitle),
                        trailing: Checkbox(
                          onChanged: (_) {
                            markDoneTodo(index: index);
                          },
                          value: state.todos[index].isDone,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              print(state.status);
              return Center(
                child: state.status == TodoStatus.error
                    ? const Text("Sorry Something Want Wrong")
                    : const CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var controller1 = TextEditingController();
          var controller2 = TextEditingController();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add Todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller1,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller2,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: 'Task description',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    addTodo(
                      todo: TodoModel(
                        title: controller1.text,
                        subtitle: controller2.text,
                      ),
                    );
                    // );
                    // controller1.dispose();
                    // controller2.dispose();
                    Navigator.pop(context);
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
