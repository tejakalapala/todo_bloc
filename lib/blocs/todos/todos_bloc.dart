import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo> (_onAddTodo);
    on<DeleteTodo> (_onDeleteTodo);
  }

  void _onLoadTodos(LoadTodos event,Emitter<TodosState> emit){
    emit(
      TodosLoaded(todos: event.todos)
    );
  }
  void _onAddTodo(AddTodo event,Emitter<TodosState> emit){
      final state = this.state;
      if(state is TodosLoaded){
        emit(
          TodosLoaded(todos: List.from(state.todos)..add(event.todo))
        );
      }
  }
  
  void _onDeleteTodo(DeleteTodo event,Emitter<TodosState> emit){
    final state = this.state;
    if(state is TodosLoaded){
      List<Todo> todos = state.todos.where((todo){
        return todo.id != event.todo.id;
      }).toList();
      emit(TodosLoaded(todos: todos));
    }

  }

}
