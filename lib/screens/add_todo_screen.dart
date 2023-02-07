import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todos/todos_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add todo"),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if(state is TodosLoaded){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("To be added")));
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _inputField('ID', controllerId),
                _inputField('Task', controllerTask),
                _inputField('Description', controllerDescription),
                ElevatedButton(
                    onPressed: (() {
                      var todo = Todo(
                          id: controllerId.value.text,
                          description: controllerTask.value.text,
                          task: controllerDescription.value.text);
                          context.read<TodosBloc>().add(AddTodo(todo: todo));
                          Navigator.pop(context);
                    }),
                    child: const Text("Add todo"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Column _inputField(String field, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$field:'),
      Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        child: TextFormField(
          controller: controller,
        ),
      )
    ],
  );
}
