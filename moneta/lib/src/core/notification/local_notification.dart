// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  // static final FlutterLocalNotificationsPlugin
  //     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // //Inicialização da notificação local
  // static Future init() async {
  //   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final DarwinInitializationSettings initializationSettingsDarwin =
  //       DarwinInitializationSettings(
  //     onDidReceiveLocalNotification: (id, title, body, payload) {},
  //   );
  //   final LinuxInitializationSettings initializationSettingsLinux =
  //       LinuxInitializationSettings(defaultActionName: 'Open notification');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //           android: initializationSettingsAndroid,
  //           iOS: initializationSettingsDarwin,
  //           linux: initializationSettingsLinux);
  //   _flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (details) {},
  //   );
  // }

  // // Mostrar uma notificação simples
  // static Future showSimpleNotification({
  //   required String title,
  //   required String body,
  //   required String payload,
  // }) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('you channel id', 'you channel name',
  //           channelDescription: 'you channel description',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           ticker: 'ticker');

  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);

  //   await _flutterLocalNotificationsPlugin
  //       .show(0, title, body, notificationDetails, payload: payload);
  // }

  // // para mostrar notificações periódicas em intervalos regulares
  // static Future showPeriodicNotifications({
  //   required String title,
  //   required String body,
  //   required String payload,
  // }) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('channel 2', 'you channel name',
  //           channelDescription: 'you channel description',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //     1,
  //     title,
  //     body,
  //     RepeatInterval.everyMinute,
  //     notificationDetails,
  //   );
  // }

  // // close a specific channel notification
  // static Future cancel(int id) async {
  //   await _flutterLocalNotificationsPlugin.cancel(id);
  // }
}
