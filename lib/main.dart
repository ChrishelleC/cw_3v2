import 'package:flutter/material.dart';

void main() {
  runApp(TaskManager());
}

class Task {
  String name;
  bool isCompleted;
  String priority;

  Task({required this.name, this.isCompleted = false, required this.priority});
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedPriority = 'Medium';
  List<Task> _tasks = [];

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: _taskController.text, priority: _selectedPriority));
        _taskController.clear();
      });
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _tasks.sort((a, b) => _priorityValue(b.priority).compareTo(_priorityValue(a.priority)));
    
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(labelText: 'Enter task'),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                  items: ['Low', 'Medium', 'High']
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _addTask, child: Text('Add')),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => _toggleTaskCompletion(index),
                    ),
                    title: Text(
                      task.name,
                      style: TextStyle(
                        decoration:
                            task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('Priority: ${task.priority}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _priorityValue(String priority) {
    switch (priority) {
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      case 'Low':
        return 1;
      default:
        return 0;
    }
  }
}
