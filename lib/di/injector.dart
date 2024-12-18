
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
final di = GetIt.instance;





Future<void> init() async {
  /// Local cache
  SharedPreferences prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => prefs);

  
  
  /// Network
  // var options = BaseOptions(
  //     baseUrl: Apis.baseUrl,
  //     connectTimeout: const Duration(seconds: 10),
  //     receiveTimeout: const Duration(seconds: 10),
  //     headers: {
  //       'accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       if (prefs.getString(SharedModel.token) != null)
  //         'Authorization': 'Bearer ${prefs.getString(SharedModel.token)}'
  //     });
  // Dio dio = Dio(options);

  // dio.interceptors.add(alice.getDioInterceptor());

  // di.registerSingleton<Dio>(dio);
  // dio.interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90));

 
}
