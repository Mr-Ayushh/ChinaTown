import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppNavigatorObserver extends GetObserver {
  static const _enableLog = true;

  AppNavigatorObserver();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (_enableLog) {
      log('didPush from ${previousRoute?.settings.name} to ${route.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (_enableLog) {
      log('didPop ${route.settings.name}, back to ${previousRoute?.settings.name}');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (_enableLog) {
      log('didRemove ${route.settings.name}, back to ${previousRoute?.settings.name}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_enableLog) {
      log('didReplace ${oldRoute?.settings.name} by ${newRoute?.settings.name}');
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    if (_enableLog) {
      log('didStartUserGesture ${route.settings.name} previous ${previousRoute?.settings.name}');
    }
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    if (_enableLog) {
      log('didStopUserGesture');
    }
  }
}
