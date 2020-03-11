import 'dart:io';

import 'package:flutter/material.dart';

class RouteUtils {
  // private contructor
  RouteUtils._();
  static RouteUtils _instance;

  // ignore: prefer_constructors_over_static_methods
  static RouteUtils getInstance() {
    // ignore: prefer_conditional_assignment
    if (_instance == null) {
      _instance = RouteUtils._();
    }
    return _instance;
  }

  BuildContext globalBuildContext;

  static Route getRoute(Widget screen, {RouteSettings settings}) {
    if (Platform.isIOS) {
      return MaterialPageRoute(
          builder: (context) => screen, settings: settings);
    } else {
      return SlideLeftRoute(enterWidget: screen);
    }
  }

  final List<WillPopCallback> _willPopCallbacks = [];
  ////////////////////////////////////////////////////////////////////////////////
  /// handle backkey of any page register,
  /// if any page return `false` => that page handel susceccfully => do nothing
  /// else all register was return `true` => handle normal
  /////////////////////////////////////////////////////////////////////////////
  Future<bool> onBackKeyPressed() async {
    if (_willPopCallbacks.isEmpty) {
      return true;
    }

    bool result = true;
    for (int i = _willPopCallbacks.length - 1; i >= 0; i--) {
      if (_willPopCallbacks[i] == null) {
        _willPopCallbacks.removeAt(i);
        continue;
      }

      if (!await _willPopCallbacks[i].call()) {
        result = false;
        break;
      }
    }
    return result;
  }

  void registerOnBackKeyPressed(WillPopCallback register) {
    _willPopCallbacks.add(register);
  }

  void unregisterOnBackKeyPressed(WillPopCallback register) {
    _willPopCallbacks.remove(register);
  }

  //dashboard data saved
  int dashboardCurrentPageIdx = 0;
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget enterWidget;
  SlideLeftRoute({
    this.enterWidget,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return enterWidget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.5, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
