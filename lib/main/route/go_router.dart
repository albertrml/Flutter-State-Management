import 'package:flutter_state_management/main/route/destine.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: allDestines
      .map(
        (Destine destine) => GoRoute(
          path: destine.route,
          builder: (context, state) => destine.page,
        ),
      )
      .toList(),
);
