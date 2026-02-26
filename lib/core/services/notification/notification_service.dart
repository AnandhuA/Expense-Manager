import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      null, // default app icon
      [
        NotificationChannel(
          channelKey: 'budget_channel',
          channelName: 'Budget Alerts',
          channelDescription: 'Notification channel for budget alerts',
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );
  }

  static Future<void> showBudgetAlert(double limit) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'budget_channel',
        title: '⚠ Budget Limit Exceeded',
        body: 'Your monthly expenses exceeded ₹$limit',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  static Future<void> requestPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
}
