// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   NotificationService._();
//   static final NotificationService instance = NotificationService._();

//   final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');

//     const settings = InitializationSettings(android: android);

//     await _plugin.initialize(settings: settings);
//   }

//   Future<void> showLimitAlert({
//     required double limit,
//     required double spent,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'limit_channel',
//       'Budget Alerts',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     await _plugin.show(
//       id: 0,
//       title: 'Budget Limit Exceeded',
//       body: 'You spent ₹$spent which exceeds your limit of ₹$limit',
//       notificationDetails: const NotificationDetails(android: androidDetails),
//     );
//   }
// }
