import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';
import '../configuration/http_helpers.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
    ) async {
  await Firebase.initializeApp();
  print('BACKGROUND MESSAGE RECEIVED');
  print('messageId: ${message.messageId}');
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('data: ${message.data}');
}
class NotificationService {
  static final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;
  static const Uuid _uuid = Uuid();
  static Future<void> initialize() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('NOTIFICATION PERMISSION:');
    print(settings.authorizationStatus);
    final fcmToken = await _messaging.getToken();
    print('FCM TOKEN:');
    print(fcmToken);
    if (fcmToken != null && fcmToken.isNotEmpty) {
      await registerToken(fcmToken);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('FOREGROUND MESSAGE RECEIVED');
      print('messageId: ${message.messageId}');
      print('title: ${message.notification?.title}');
      print('body: ${message.notification?.body}');
      print('data: ${message.data}');
    });
    _messaging.onTokenRefresh.listen((newToken) async {
      print('FCM TOKEN REFRESHED:');
      print(newToken);
      await registerToken(newToken);
    });
  }
  static Future<void> registerToken(String fcmToken) async {
    final box = GetStorage();
    final authToken = box.read<String>('token');
    if (authToken == null || authToken.isEmpty) {
      print('NO AUTH TOKEN - SKIPPING PUSH TOKEN REGISTRATION');
      return;
    }
    String? deviceId = box.read<String>('push_device_id');
    if (deviceId == null || deviceId.isEmpty) {
      deviceId = _uuid.v4();
      await box.write(
        'push_device_id',
        deviceId,
      );
      print('NEW DEVICE ID CREATED:');
      print(deviceId);
    } else {
      print('EXISTING DEVICE ID:');
      print(deviceId);
    }
    final response = await HttpHelper.postData(
      url: 'devices/push-token',
      body: {
        'device_id': deviceId,
        'platform': 'android',
        'token': fcmToken,
      },
    );
    print('PUSH TOKEN REGISTER');
    print('device_id: $deviceId');
    print('platform: android');
    print('status: ${response.statusCode}');
    print('body: ${response.body}');
  }
}