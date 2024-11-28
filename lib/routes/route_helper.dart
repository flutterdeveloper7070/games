import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_demo/pages/games/games_page.dart';

import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String initial = '/';
  static const String games = '/games';
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('MyTest didReplace: $newRoute');
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

String? _redirect(BuildContext context, GoRouterState state) {
  log("_redirect -> ${state.uri.path}");
  return state.uri.path; // initially it was '/' then path
}

final router = GoRouter(
  initialLocation: RouteHelper.initial,
  navigatorKey: _rootNavigatorKey,
  redirect: _redirect,
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      path: RouteHelper.initial,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: SplashPage(),
        );
      },
    ),
    GoRoute(
      path: RouteHelper.games,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: GamesPage(),
        );
      },
    ),
  ],
);
