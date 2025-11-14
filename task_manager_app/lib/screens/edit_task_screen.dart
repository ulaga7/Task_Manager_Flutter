import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../services/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final ParseObject? task;
  const EditTaskScreen({super.key, this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title.text = widget.task!.get<String>('title') ?? '';
      _desc.text = widget.task!.get<String>('description') ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskSvc = Provider.of<TaskService>(context, listen: false);
    final isEdit = widget.task != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Task' : 'Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _desc, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 12),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () async {
                      final t = _title.text.trim();
                      if (t.isEmpty) {
                        setState(() { _error = 'Title required'; });
                        return;
                      }
                      setState(() { _loading = true; _error = null; });
                      if (isEdit) {
                        await taskSvc.updateTask(widget.task!, t, _desc.text.trim());
                      } else {
                        await taskSvc.createTask(t, _desc.text.trim());
                      }
                      setState(() { _loading = false; });
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
              child: _loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : Text(isEdit ? 'Save' : 'Create'),
            ),
          ],
        ),
      ),
    );
  }
}
