import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/component/genre_filter.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/component/movie_card.dart';
import 'package:flutter_state_management/app_state/bloc_cubit/logic/cubit/movie_cubit.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieCubit movieCubit = MovieCubit();

  @override
  void initState() {
    super.initState();
    movieCubit.getMovies();
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
              GenreFilter(movieCubit: movieCubit),
              BlocBuilder<MovieCubit, Response>(
                bloc: movieCubit,
                builder: (context, state) {
                  switch (state) {
                    case Success(:final result):
                      {
                        return SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisExtent: 300,
                              ),
                          itemBuilder: (context, index) {
                            return MovieCard(movie: result[index]);
                          },
                          itemCount: result.length,
                        );
                      }

                    case Failure(:final exception):
                      return SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.not_interested, size: 30),
                            const SizedBox(height: 16),
                            Text(
                              exception.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );

                    default:
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
