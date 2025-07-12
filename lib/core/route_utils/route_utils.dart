import 'package:flutter/material.dart';
import 'package:graduation_project/features/patient/home/presentation/views/home_view.dart';

class RouteUtils {
  static Future<dynamic> push(BuildContext context, Widget view) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => view,
      ),
    );
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget view) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => view,
      ),
    );
  }

  static Future<dynamic> pushAndRemoveAll(BuildContext context, Widget view) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => view,
      ),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    return Navigator.of(context).pop();
  }
  static void pushAndRemoveUntil(BuildContext context, HomeView homeView) {}
}
