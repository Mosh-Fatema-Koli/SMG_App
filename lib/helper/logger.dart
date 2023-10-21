import 'package:logger/logger.dart';

logger(Type type) => Logger(printer: CustomPrinter(type.toString()));


class CustomPrinter extends LogPrinter {
  final String className;
  CustomPrinter(this.className);
  @override
  List<String> log(LogEvent event) {
   
    final emoji = PrettyPrinter();
    final message = event.message;
    return [('$emoji $className : $message')];
  }
}