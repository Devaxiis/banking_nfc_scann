
import 'package:bankingapp/common/theme/theme.dart';

abstract class OrderStatus {
  static const start = 'start';
  static const loaded = 'loaded';
  static const inFactory = 'in_factory';
  static const hasLocation = 'has_location';
  static const finish = 'finish';
}

late ThemeNotifier themeNotifier;

const appVersion = '1.0.0';

