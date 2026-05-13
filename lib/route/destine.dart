import 'package:flutter/material.dart';

sealed class Destine {
  final String title;
  final IconData icon;
  final String description;
  final String route;

  Destine({
    required this.title,
    required this.icon,
    required this.description,
    required this.route,
  });
}

final class HomePage extends Destine {
  HomePage()
    : super(
        title: 'Home Page',
        icon: Icons.home,
        description: 'Examples of state management',
        route: '/',
      );
}

// EPHEMERAL STATE MANAGEMENT

final class CounterPage extends Destine {
  CounterPage()
    : super(
        title: 'Counter',
        icon: Icons.numbers,
        description: 'Example of ephemeral state management by UI state',
        route: '/counter',
      );
}

final class DayShiftPage extends Destine {
  DayShiftPage()
    : super(
        title: 'Sky Mode',
        icon: Icons.cloud,
        description: 'Example of ephemeral state management by ValueNotifier',
        route: '/day-shift',
      );
}

List<Destine> ephemeralStatedestines = <Destine>[CounterPage(), DayShiftPage()];

// APP STATE MANAGEMENT

final class TimeSpentPage extends Destine {
  TimeSpentPage()
    : super(
        title: 'Time Spent',
        icon: Icons.pie_chart,
        description: 'Example of app state management by lifting state up',
        route: '/time-spent',
      );
}

final class CreateColorPage extends Destine {
  CreateColorPage()
    : super(
        title: 'Create RGB Color',
        icon: Icons.colorize,
        description:
            'Example of app state management by multiprovider and multiconsumer',
        route: '/create-rgb-color',
      );
}

final class MoviePage extends Destine {
  MoviePage()
    : super(
        title: 'Movie List',
        icon: Icons.smart_screen,
        description: 'Example of app state management by BLoC and Cubit',
        route: '/movie-screen',
      );
}

final class BlocProviderLifeccyclePage extends Destine {
  BlocProviderLifeccyclePage()
    : super(
        title: 'Bloc Provider Lifecycle',
        icon: Icons.account_tree,
        description: 'Demonstrates BlocProvider ownership and Cubit lifecycle',
        route: '/bloc-provider-lifecycle',
      );
}

List<Destine> appStateDestines = <Destine>[
  TimeSpentPage(),
  CreateColorPage(),
  MoviePage(),
  BlocProviderLifeccyclePage(),
];
