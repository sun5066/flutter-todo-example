import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Todo {
  bool isComplete = false;
  String title;

  Todo(this.title);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: TodoListAdapter(),
    );
  }
}

class TodoListAdapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoListAdapter> {
  final _itemList = <Todo>[];
  var _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: TextField(
                  controller: _todoController,
                )),
                RaisedButton(
                  onPressed: () => _add(Todo(_todoController.text)),
                  color: Colors.green,
                  child: Text(
                    '추가하기',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView(
              children:
                  _itemList.map((todo) => _buildItemWidget(todo)).toList(),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      onTap: () => _toggleTodo(todo),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _delete(todo),
      ),
      title: Text(
        todo.title,
        style: todo.isComplete
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic)
            : null,
      ),
    );
  }

  void _add(Todo todo) => setState(() {
        _itemList.add(todo);
        _todoController.text = '';
      });

  void _delete(Todo todo) => setState(() {
        _itemList.remove(todo);
      });

  void _toggleTodo(Todo todo) => setState(() {
        todo.isComplete = !todo.isComplete;
      });
}
