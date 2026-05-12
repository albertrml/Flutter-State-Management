import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/logic/cubit/movie_cubit.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/genre.dart';

class GenreFilter extends StatefulWidget {
  final MovieCubit movieCubit;
  const GenreFilter({super.key, required this.movieCubit});

  @override
  State<GenreFilter> createState() => _GenreFilterState();
}

class _GenreFilterState extends State<GenreFilter> {
  String selectedGenre = defaultGenre;
  final dropdownItems = getItems(listGenres);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Gênero ', style: Theme.of(context).textTheme.titleMedium),

          DropdownButton(
            value: selectedGenre,
            items: dropdownItems,
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                selectedGenre = value;
              });

              widget.movieCubit.getMovies(genre: value);
            },
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> getItems(List<String> items) {
  return items
      .map<DropdownMenuItem<String>>(
        (value) => DropdownMenuItem(value: value, child: Text(value)),
      )
      .toList();
}
