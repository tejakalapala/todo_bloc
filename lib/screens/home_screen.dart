

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todos/todos_bloc.dart';
import 'package:todo_bloc/screens/add_todo_screen.dart';

import '../models/todo_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Pattern Todos"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const AddTodoScreen())));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if(state is TodosLoading){
            return const CircularProgressIndicator();
          }else if(state is TodosLoaded){
            return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Pending To-Dos"),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) =>
                        _todoCard(context,state.todos[index]))
              ],
            ),
          );
          }else{
            return const Text("Something is wrong");
          }
          
        },
      ),
    );
  }
}

Card _todoCard(BuildContext context, Todo todo) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${todo.id}:${todo.task}"),
          Row(
            children: [
              IconButton(onPressed: () {
                context.read<TodosBloc>().add(DeleteTodo(todo: todo));
              }, icon: const Icon(Icons.cancel)),
            ],
          )
        ],
      ),
    ),
  );
}
