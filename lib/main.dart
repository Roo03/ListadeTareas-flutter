import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Lista de tareas';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const ListaTareas(),
    );
  }
}

class ListaTareas extends StatefulWidget {
  const ListaTareas({super.key});

  @override
  _ListaTareasState createState() => _ListaTareasState();
}

class _ListaTareasState extends State<ListaTareas> {
  final List<String> _tasks = []; // Lista para almacenar las tareas
  final TextEditingController _textController = TextEditingController();
  String _editingTask = '';
  int? _editingIndex;

  void _addTask() {
    setState(() {
      if (_textController.text.isNotEmpty) {
        _tasks.add(_textController.text); // Agregar la tarea a la lista
        _textController.clear(); // Limpiar el campo de texto
      }
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Eliminar la tarea de la lista
    });
  }

  void _editTask(int index) {
    setState(() {
      _editingTask =
          _tasks[index]; // Poner el texto actual en el campo de edición
      _editingIndex =
          index; // Guardar el índice de la tarea que se está editando
      _textController.text = _editingTask;
    });
  }

  void _saveEditedTask() {
    if (_editingIndex != null) {
      setState(() {
        _tasks[_editingIndex!] =
            _textController.text; // Guardar la tarea editada
        _editingIndex = null; // Limpiar el estado de edición
        _textController.clear(); // Limpiar el campo de texto
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Añadir o Editar Tarea',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _editingIndex == null ? _addTask : _saveEditedTask,
                  child: Text(_editingIndex == null ? 'Añadir' : 'Guardar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('Aún no hay tareas'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_tasks[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editTask(index), // Editar tarea
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _removeTask(index), // Eliminar tarea
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
