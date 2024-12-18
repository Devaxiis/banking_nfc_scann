import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';
import 'di/injector.dart' as sl;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}
