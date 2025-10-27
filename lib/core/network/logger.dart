import 'package:logger/logger.dart';

Logger get logger => Logger(
      printer: PrettyPrinter(
        methodCount: 0,
      ),
    );
