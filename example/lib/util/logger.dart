import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger()
  ..mode = LoggerMode.print
  ..setLevel(
    Level.FINEST,
    includeCallerInfo: true,
  );
