import 'dart:io';
import 'package:logger/logger.dart';

/// A comprehensive logging utility for the application
///
/// Features:
/// - Console logging with colors and emojis
/// - File logging (optional)
/// - Network logging (optional)
/// - Different log levels
class AppLogger {
  static final Logger _consoleLogger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Log a debug message
  static void d(dynamic message) {
    _consoleLogger.d(message);
  }

  /// Log an info message
  static void i(dynamic message) {
    _consoleLogger.i(message);
  }

  /// Log a warning message
  static void w(dynamic message) {
    _consoleLogger.w(message);
  }

  /// Log an error message
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _consoleLogger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a verbose message
  static void v(dynamic message) {
    _consoleLogger.v(message);
  }

  /// Log to file (optional)
  static Future<void> logToFile(String message) async {
    // Implementation for file logging
    // final file = File('logs/app_logs.txt');
    // await file.writeAsString('${DateTime.now()}: $message\n', mode: FileMode.append);
  }

  /// Log to network (optional)
  static Future<void> logToNetwork(String message) async {
    // Implementation for network logging
    // await http.post(Uri.parse('https://api.example.com/logs'),
    //   body: {'message': message});
  }
}

/// Global logger instance for quick access
final logger = AppLogger();
