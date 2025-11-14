import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TaskService extends ChangeNotifier {
  ParseUser? _user;
  List<ParseObject> tasks = [];

  /// Called whenever AuthService changes user (login/logout)
  void updateUser(ParseUser? user) {
    _user = user;

    if (_user != null) {
      fetchTasks();
    } else {
      tasks = [];
      notifyListeners();
    }
  }

  /// Fetch all tasks belonging to the logged-in user
  Future<void> fetchTasks() async {
    if (_user == null) return;

    final query = QueryBuilder<ParseObject>(ParseObject('Task'))
      ..whereEqualTo('owner', _user!) // Dart SDK auto-converts to Pointer
      ..orderByDescending('createdAt');

    final response = await query.query();

    if (response.success) {
      tasks = (response.results ?? []).cast<ParseObject>();
      notifyListeners();
    }
  }

  /// Create a new Task
  Future<ParseResponse> createTask(String title, String description) async {
    if (_user == null) {
      return ParseResponse()
        ..error = ParseError(message: 'Not logged in')
        ..statusCode = -1;
    }

    final task = ParseObject('Task')
      ..set<String>('title', title)
      ..set<String>('description', description)
      ..set<ParseUser>('owner', _user!)   // Saves as Pointer
      ..setACL(ParseACL(owner: _user!));  // Only user can read/write

    final response = await task.save();

    if (response.success) {
      await fetchTasks();
    }

    return response;
  }

  /// Update an existing task
  Future<ParseResponse> updateTask(
    ParseObject task,
    String title,
    String description,
  ) async {
    task
      ..set<String>('title', title)
      ..set<String>('description', description);

    final response = await task.save();

    if (response.success) {
      await fetchTasks();
    }

    return response;
  }

  /// Delete a task
  Future<ParseResponse> deleteTask(ParseObject task) async {
    final response = await task.delete();

    if (response.success) {
      await fetchTasks();
    }

    return response;
  }
}
