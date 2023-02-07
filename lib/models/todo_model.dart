import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todo extends Equatable{
  final String id,task,description;
  bool? isCompleted;
  bool? isCancelled;
  Todo({
    required this.id,
    required this.description,
    required this.task,
    this.isCancelled,
    this.isCompleted
  }){
    isCancelled = isCancelled ?? false;
    isCompleted = isCompleted ?? false;
  }
  
  @override
  
  List<Object?> get props => [id,task,description,isCancelled,isCompleted];

  static List<Todo>todos = [
    Todo(id: "1", description: "This is a test todo", task: "Sample todo1"),
    Todo(id: "2", description: "This is a test todo", task: "Sample todo2")
  ];

}