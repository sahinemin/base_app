import 'package:base_app/config/router/routes.dart'; // Import generated routes
import 'package:base_app/core/di/injection.dart';
import 'package:base_app/core/error/failures.dart';
import 'package:base_app/core/presentation/widgets/error_display.dart'; // Shared error widget
import 'package:base_app/features/todo/domain/entities/priority.dart';
import 'package:base_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create instance using getIt
      create:
          (context) => getIt<TodoBloc>()..add(const WatchTodosSubscription()),
      child: const _TodoView(),
    );
  }
}

class _TodoView extends StatefulWidget {
  const _TodoView();

  @override
  State<_TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<_TodoView> {
  final _jobController = TextEditingController();
  final _createdByController = TextEditingController(
    text: 'TestUser',
  ); // Hardcoded for test
  Priority _selectedPriority = Priority.medium;
  DateTime? _selectedExpirationDate;

  @override
  void dispose() {
    _jobController.dispose();
    _createdByController.dispose();
    super.dispose();
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedExpirationDate ??
          DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedExpirationDate) {
      setState(() {
        _selectedExpirationDate = picked;
      });
    }
  }

  void _addTodo() {
    context.read<TodoBloc>().add(
      AddTodo(
        job: _jobController.text,
        createdBy: _createdByController.text,
        priority: _selectedPriority,
        expirationDate: _selectedExpirationDate,
      ),
    );
    // Clear fields after adding
    _jobController.clear();
    setState(() {
      _selectedPriority = Priority.medium;
      _selectedExpirationDate = null;
    });
    FocusScope.of(context).unfocus(); // Dismiss keyboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DDD Todo App')),
      body: Column(
        children: [
          // Input Area
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _jobController,
                      decoration: const InputDecoration(labelText: 'Job'),
                    ),
                    // TextField( // Optional: if createdBy shouldn't be hardcoded
                    //   controller: _createdByController,
                    //   decoration: const
                    // InputDecoration(labelText: 'Created By'),
                    // ),
                    Row(
                      children: [
                        const Text('Priority:'),
                        const SizedBox(width: 8),
                        DropdownButton<Priority>(
                          value: _selectedPriority,
                          onChanged: (Priority? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedPriority = newValue;
                              });
                            }
                          },
                          items:
                              Priority.values.map<DropdownMenuItem<Priority>>((
                                Priority value,
                              ) {
                                return DropdownMenuItem<Priority>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            _selectedExpirationDate == null
                                ? 'Set Date'
                                : '${_selectedExpirationDate!.toLocal()}'.split(
                                  ' ',
                                )[0],
                          ),
                          onPressed: () => _selectExpirationDate(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _addTodo,
                      child: const Text('Add Todo'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // To-do List Area
          Expanded(
            child: BlocConsumer<TodoBloc, TodoState>(
              listener: (context, state) {
                if (state is TodoError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              buildWhen: (previous, current) => current is! TodoError,
              builder: (context, state) {
                return switch (state) {
                  TodoInitial() || TodoLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  // Handle unexpected detail state on list page
                  TodoDetailLoaded() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  TodoError(message: final msg) => Center(
                    child: ErrorDisplay(
                      // Using generic failure for simplicity,
                      // ideally map message
                      failure: CacheFailure(detailMessage: msg),
                      onRetry:
                          () => context.read<TodoBloc>().add(
                            const WatchTodosSubscription(),
                          ),
                    ),
                  ),
                  TodoLoaded(todos: final todos) => ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return InkWell(
                        onTap: () {
                          // Navigate using the generated typed route
                          TodoDetailRoute(todoId: todo.id).push<void>(context);
                        },
                        child: ListTile(
                          title: Text(
                            todo.job.value, // Use value from VO
                            style: TextStyle(
                              decoration:
                                  todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                            ),
                          ),
                          subtitle: Text(
                            '''Created by: ${todo.createdBy.value} - Priority: ${todo.priority.name}${todo.expirationDate.value != null ? ' - Due: ${todo.expirationDate.value!.toLocal()}'.split(' ')[0] : ''}''',
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (bool? value) {
                              if (value != null) {
                                context.read<TodoBloc>().add(
                                  UpdateTodo(todo.copyWith(isCompleted: value)),
                                );
                              }
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<TodoBloc>().add(DeleteTodo(todo.id));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
