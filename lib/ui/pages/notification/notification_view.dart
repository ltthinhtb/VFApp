import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notification_logic.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final logic = Get.put(NotificationLogic());
  final state = Get.find<NotificationLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<NotificationLogic>();
    super.dispose();
  }
}