import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/component/genre_filter.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/component/movie_card.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/logic/cubit/movie_cubit.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/model/movie.dart';

/*
 * The MovieCubit is provided to MovieScreen so the widget tree
 * can react to state changes.
 *
 * Two important steps are required:
 *
 * 1. Create a MovieCubit instance
 * 2. Connect reactive widgets to the Cubit's state
 *
 * In this example, two widgets depend on MovieCubit:
 *
 * - GenreFilter
 * - BlocBuilder
 *
 * For educational purposes, this example demonstrates dependency
 * injection through constructor parameters instead of BlocProvider.
 * For more details about BlocProvider, see the bloc_provider_lifecycle
 * example.
 */
class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  /*
   * 8. Create an instance of MovieCubit.
   *
   * The Cubit will be responsible for:
   *
   * - managing business logic
   * - handling async operations
   * - emitting UI states
   */
  final MovieCubit movieCubit = MovieCubit();

  @override
  void initState() {
    super.initState();
    // 9. Trigger the initial movie loading when the screen starts.
    movieCubit.getMovies();
  }

  @override
  void dispose() {
    /*
   * 10. Since MovieScreen manually creates the Cubit,
   * it also becomes responsible for disposing it.
   *
   * Cubits internally manage Streams and resources
   * that must be properly closed to prevent leaks.
   */
    movieCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Text(
                  "Filmes",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),

              /*
               * 13. GenreFilter receives the MovieCubit instance
               * through constructor injection.
               *
               * This allows the widget to trigger Cubit actions
               * without directly creating or owning the Cubit.
               *
               * In larger applications, BlocProvider is usually
               * preferred to share Cubits across the widget tree.
               */
              GenreFilter(movieCubit: movieCubit),

              /*
               * 11. BlocBuilder rebuilds its widget subtree whenever
               * the Cubit emits a new state.
               *
               * Generic parameters:
               *
               * - MovieCubit: the Cubit responsible for state management.
               *
               * - Response<List<Movie>>: the type representing all possible
               *   UI states
               *
               * The `bloc` parameter specifies which Cubit instance
               * this builder should observe.
               */
              BlocBuilder<MovieCubit, Response<List<Movie>>>(
                bloc: movieCubit,
                builder: (context, state) {
                  /*
                   * 12. The UI reacts declaratively to each state.
                   * Each state corresponds to a different widget tree.
                   */
                  switch (state) {
                    // Success state: Display the movie list.
                    case Success():
                      {
                        return SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisExtent: 300,
                              ),
                          itemBuilder: (context, index) {
                            return MovieCard(movie: state.result[index]);
                          },
                          itemCount: state.result.length,
                        );
                      }

                    // Failure state: Display an error message.
                    case Failure():
                      return SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.not_interested, size: 30),
                            const SizedBox(height: 16),
                            Text(
                              state.exception.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );

                    /* 
                     * Loading state: Display a loading indicator while
                     * waiting for async operations to complete.
                     */
                    case Loading():
                      return SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
