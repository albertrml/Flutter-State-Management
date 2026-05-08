import 'package:go_router/go_router.dart';
import 'package:flutter_state_management/ephemeral_state/local_state/counter.dart';
import 'package:flutter_state_management/ephemeral_state/value_notifier/view/day_shift.dart';
import 'package:flutter_state_management/view/home_page_screen.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/view/lifting_state_up.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/view/multiprovider_state.dart';

final GoRouter router = GoRouter(
  routes: [
    // Root route
    GoRoute(path: '/', builder: (ctx, state) => const HomePageScreen()),

    // Counter Feature route
    GoRoute(path: '/counter', builder: (ctx, state) => const Counter()),

    // Sky Mode Feature route
    GoRoute(path: '/day-shift', builder: (ctx, state) => const DayShift()),

    // Time Spent Feature route
    GoRoute(
      path: '/time-spent',
      builder: (ctx, state) => const LiftingStateUp(),
    ),

    // Create Color Feature route
    GoRoute(
      path: '/create-rgb-color',
      builder: (ctx, state) => const MultiproviderState(),
    ),
  ],
);
