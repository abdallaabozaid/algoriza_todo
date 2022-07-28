import 'package:flutter/material.dart';
import 'package:todo_app/src/infrastructure/02_notification/local/notification_api.dart';
import 'package:todo_app/src/presentation/core_widgets/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationApi.init();
  runApp(const AppWidget());
}
