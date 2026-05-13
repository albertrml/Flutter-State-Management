import 'package:flutter/material.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/logic/cubit/movie_cubit.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/genre.dart';

/*
 * GenreFilter is responsible only for:
 *
 * - displaying the available movie genres
 * - handling local UI selection state
 * - requesting filtered movies from MovieCubit
 *
 * This widget does NOT manage the movie list state itself.
 * The movie loading state is handled by MovieCubit.
 */
class GenreFilter extends StatefulWidget {
  /*
   * 13. The MovieCubit instance is received through constructor injection.
   *
   * This allows the widget to communicate with the business logic layer
   * without creating its own Cubit instance.
   */
  final MovieCubit movieCubit;
  const GenreFilter({super.key, required this.movieCubit});

  @override
  State<GenreFilter> createState() => _GenreFilterState();
}

class _GenreFilterState extends State<GenreFilter> {
  /*
   * Local UI state:
   *
   * selectedGenre stores the currently selected item
   * displayed by the DropdownButton.
   *
   * This is considered ephemeral/local widget state because:
   *
   * - it only affects this widget
   * - it does not need global sharing
   * - it is purely visual/UI-related
   */
  String selectedGenre = defaultGenre;

  /*
   * Convert the genre list into DropdownMenuItem widgets.
   *
   * This transformation is done once when the state object
   * is created, avoiding unnecessary rebuild work.
   */
  final dropdownItems = getItems(listGenres);

  @override
  Widget build(BuildContext context) {
    /*
     * SliverToBoxAdapter allows regular widgets to be inserted
     * inside a CustomScrollView sliver structure.
     */
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Gênero ', style: Theme.of(context).textTheme.titleMedium),

          /*
           * DropdownButton displays all available genres and
           * notifies changes when the user selects a new item.
           */
          DropdownButton(
            value: selectedGenre,
            items: dropdownItems,
            onChanged: (value) {
              // Ignore null values for safety.
              if (value == null) return;

              /*
               * setState updates the local widget state,
               * forcing GenreFilter to rebuild with the
               * newly selected option.
               *
               * This affects only the UI selection state.
               */
              setState(() {
                selectedGenre = value;
              });

              /*
               * 14. Request a new movie list from MovieCubit
               * using the selected genre.
               *
               * The Cubit will:
               *
               * - emit Loading
               * - perform async work
               * - emit Success or Failure
               *
               * Widgets connected through BlocBuilder
               * will rebuild automatically.
               */
              widget.movieCubit.getMovies(genre: value);
            },
          ),
        ],
      ),
    );
  }
}

/*
 * Converts a list of String values into DropdownMenuItem widgets.
 *
 * Example:
 *
 * ['Action', 'Drama']
 *
 * becomes:
 *
 * [
 *   DropdownMenuItem(value: 'Action'),
 *   DropdownMenuItem(value: 'Drama'),
 * ]
 */
List<DropdownMenuItem<String>> getItems(List<String> items) {
  return items
      .map<DropdownMenuItem<String>>(
        (value) => DropdownMenuItem(value: value, child: Text(value)),
      )
      .toList();
}
