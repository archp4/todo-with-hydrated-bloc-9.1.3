import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_with_local_storage_and_bloc/bloc/todo_bloc.dart';
import 'package:todo_with_local_storage_and_bloc/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App With Hydrated Bloc',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Colors.yellowAccent,
          onPrimary: Colors.black,
          secondary: Colors.lightGreen,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TodoBloc()..add(TodoStarted()),
        child: const HomeScreen(),
      ),
    );
  }
}
