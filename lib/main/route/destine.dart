import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/view/movie_screen.dart';
import 'package:flutter_state_management/app_state/bloc_provider_lifecycle/view/bloc_provider_counter_screen.dart';
import 'package:flutter_state_management/app_state/lifting_state_up/view/lifting_state_up.dart';
import 'package:flutter_state_management/app_state/multiprovider_multiconsumer/view/multiprovider_state.dart';
import 'package:flutter_state_management/ephemeral_state/local_state/counter.dart';
import 'package:flutter_state_management/ephemeral_state/value_notifier/view/day_shift.dart';
import 'package:flutter_state_management/main/view/home_page_screen.dart';

enum StateManagementType {
  localState(name: 'Local State'),
  valueNotifier(name: 'ValueNotifier'),
  liftingStateUp(name: 'Lifting State Up'),
  multiprovider(name: 'MultiProvider'),
  blocCubitManual(name: 'BLoC/Cubit Manual'),
  blocProviderLifecycle(name: 'BLoC/Provider Lifecycle'),
  none(name: 'None');

  final String name;
  const StateManagementType({required this.name});
}

enum StateManagementCategory { ephemeral, app, none }

class Destine {
  final String title;
  final StateManagementType type;
  final StateManagementCategory category;
  final IconData icon;
  final String description;
  final String route;
  final Widget page;

  const Destine({
    required this.title,
    required this.type,
    required this.category,
    required this.icon,
    required this.description,
    required this.route,
    required this.page,
  });
}

const List<Destine> allDestines = <Destine>[
  // HOME PAGE
  Destine(
    title: 'Home Page',
    type: StateManagementType.none,
    category: StateManagementCategory.none,
    icon: Icons.home,
    description: 'Examples of state management',
    route: '/',
    page: HomePageScreen(title: 'Home Page'),
  ),

  // EPHEMERAL STATE MANAGEMENT
  Destine(
    title: 'Counter',
    type: StateManagementType.localState,
    category: StateManagementCategory.ephemeral,
    icon: Icons.numbers,
    description: 'Example of ephemeral state management by UI state',
    route: '/counter',
    page: UIStateCounterScreen(title: 'Counter'),
  ),

  Destine(
    title: 'Day shift',
    type: StateManagementType.valueNotifier,
    category: StateManagementCategory.ephemeral,
    icon: Icons.cloud,
    description: 'Example of ephemeral state management by ValueNotifier',
    route: '/day-shift',
    page: ValueNotifierDayShiftScreen(title: 'Day Shift'),
  ),

  // APP STATE MANAGEMENT
  Destine(
    title: 'Time Spent',
    type: StateManagementType.liftingStateUp,
    category: StateManagementCategory.app,
    icon: Icons.pie_chart,
    description: 'Example of app state management by lifting state up',
    route: '/time-spent',
    page: LiftingStateUpTimeSpentScreen(title: 'Time Spent'),
  ),

  Destine(
    title: 'Create RGB Color',
    type: StateManagementType.multiprovider,
    category: StateManagementCategory.app,
    icon: Icons.colorize,
    description:
        'Example of app state management by multiprovider and multiconsumer',
    route: '/create-rgb-color',
    page: MultiproviderRGBColorScreen(title: 'Create RGB Color'),
  ),

  Destine(
    title: 'Movie List',
    type: StateManagementType.blocCubitManual,
    category: StateManagementCategory.app,
    icon: Icons.smart_screen,
    description: 'Example of app state management by BLoC and Cubit',
    route: '/movie-screen',
    page: BlocCubitManualMovieScreen(title: 'Movie List'),
  ),

  Destine(
    title: 'BlocProvider Counter',
    type: StateManagementType.blocProviderLifecycle,
    category: StateManagementCategory.app,
    icon: Icons.account_tree,
    description: 'Demonstrates BlocProvider ownership and Cubit lifecycle',
    route: '/bloc-provider-lifecycle',
    page: BlocProviderCounterScreen(title: 'BlocProvider Counter'),
  ),
];

final Map<StateManagementType, List<Destine>> ephemeralStateDestines =
    allDestines
        .where(
          (destine) => destine.category == StateManagementCategory.ephemeral,
        )
        .groupListsBy((item) => item.type);

final Map<StateManagementType, List<Destine>> appStateDestines = allDestines
    .where((item) => item.category == StateManagementCategory.app)
    .groupListsBy((item) => item.type);
