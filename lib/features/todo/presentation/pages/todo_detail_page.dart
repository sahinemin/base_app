import 'package:base_app/core/di/injection.dart';
import 'package:base_app/core/error/failures.dart';
import 'package:base_app/core/presentation/widgets/error_display.dart';
import 'package:base_app/features/todo/domain/entities/todo.dart';
import 'package:base_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For date formatting

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({required this.todoId, super.key});
  final int todoId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // Important: Use BlocProvider.value if reusing an existing BLoC instance
      // If you want a BLoC instance scoped ONLY to this page,
      //use BlocProvider(create: ...)
      // For now, let's assume we might reuse the main list BLoC
      // but be careful about state conflicts if not managed well.
      // A dedicated Detail BLoC is often cleaner.
      value: getIt<TodoBloc>()..add(LoadTodoById(todoId)),
      child: const _TodoDetailView(),
    );
  }
}

class _TodoDetailView extends StatelessWidget {
  const _TodoDetailView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
        // Optionally add edit/delete actions here
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return switch (state) {
            TodoInitial() ||
            TodoLoading() => const Center(child: CircularProgressIndicator()),
            TodoError(message: final msg) => Center(
              child: ErrorDisplay(
                failure: CacheFailure(
                  detailMessage: msg,
                ), // Example failure type
                onRetry:
                    () => context.read<TodoBloc>().add(
                      const LoadTodoById(
                        // Need ID here!
                        // How to get ID? 
                        //It needs to be available in the view state
                        // or passed differently. 
                        //This highlights a limitation of
                        // reusing the single BLoC here.
                        // For now, this retry 
                        //won't work correctly without the ID.
                        0, // Placeholder - NEEDS FIX if retry is important
                      ),
                    ),
              ),
            ),
            TodoDetailLoaded(todo: final todo) => _buildTodoDetails(
              context,
              todo,
              textTheme,
            ),
            // Handle other states 
            //like TodoLoaded for the list) if necessary
            // If reusing the Bloc, 
            //the state might revert to TodoLoaded after an update.
            // A dedicated detail BLoC avoids this issue.
            _ => const Center(child: Text('Unexpected state')), // Default case
          };
        },
      ),
    );
  }

  Widget _buildTodoDetails(
    BuildContext context,
    Todo todo,
    TextTheme textTheme,
  ) {
    final dateFormat = DateFormat.yMMMd().add_jm(); // Example format

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        // Use ListView for potentially long content
        children: [
          Text(todo.job.value, style: textTheme.headlineMedium),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.person_outline,
            label: 'Created By:',
            value: todo.createdBy.value,
            textTheme: textTheme,
          ),
          _buildDetailRow(
            icon: Icons.priority_high,
            label: 'Priority:',
            value: todo.priority.name,
            textTheme: textTheme,
          ),
          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Created At:',
            value: dateFormat.format(todo.createdAt.toLocal()),
            textTheme: textTheme,
          ),
          if (todo.expirationDate.value != null)
            _buildDetailRow(
              icon: Icons.timer_outlined,
              label: 'Expiration Date:',
              value: dateFormat.format(todo.expirationDate.value!.toLocal()),
              textTheme: textTheme,
              isPastDue: todo.isDue && !todo.isCompleted,
            ),
          _buildDetailRow(
            icon:
                todo.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
            label: 'Status:',
            value: todo.isCompleted ? 'Completed' : 'Pending',
            textTheme: textTheme,
          ),
          // Add Edit/Delete Buttons or other actions if needed
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required TextTheme textTheme,
    bool isPastDue = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Text('$label ', style: textTheme.titleMedium),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyLarge?.copyWith(
                color: isPastDue ? Colors.red : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
