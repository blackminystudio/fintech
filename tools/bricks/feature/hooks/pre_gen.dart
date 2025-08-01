import 'package:mason/mason.dart';

void run(HookContext context) {
  // Read vars.
  final name = context.vars['name'];

  // Use the `Logger` instance.
  context.logger.success('Starting $name!');

  // Update vars.
  context.vars['current_year'] = DateTime.now().year;
}
