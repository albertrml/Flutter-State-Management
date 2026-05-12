import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.hardEdge,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 230),
            child: InkWell(child: getPoster(movie.imageURI)),
          ),
        ),

        Text(
          movie.name,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

Ink getPoster(String? uri) => Ink(
  width: double.infinity,
  decoration: uri != null
      ? BoxDecoration(
          image: DecorationImage(image: NetworkImage(uri), fit: BoxFit.cover),
        )
      : null,
  child: uri == null ? const Center(child: Icon(Icons.error)) : null,
);
