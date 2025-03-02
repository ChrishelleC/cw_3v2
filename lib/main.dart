import 'package:flutter/material.dart';

void main() {
  runApp(TaskManager());
}

class Task {
  String name;
  bool isCompleted;
  String priority;

  task({required this.name, this.isCompleted = false, required this.priority});
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskList(),
    );
  }
}
class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedPriority = 'Medium';
  List<Task> _tasks = [];

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _task.add(Task(name: _taskController.text, priority: _selectedPriority));
        _taskController.clear();
      });
    }
  }

  void _toggleTaskCompletion(int index) {
    setState((){
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }
  
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }
}
