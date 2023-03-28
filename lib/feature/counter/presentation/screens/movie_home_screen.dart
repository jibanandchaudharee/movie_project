import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project/core/router.gr.dart';
import 'package:movie_project/core/utils/shared_pref.dart';
import 'package:movie_project/feature/counter/presentation/blocs/movie_cubit/movie_cubit.dart';
import 'package:movie_project/feature/counter/presentation/blocs/movie_cubit/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_project/feature/counter/presentation/widgets/movie_list_widgets.dart';
import 'package:movie_project/main.dart';

import 'movie_detail_screen.dart';


class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  late MovieCubit _movieCubit;
  late MovieDetailsCubit _movieDetailsCubit;

  @override
  void initState() {
    super.initState();
    setAppBarTitle();
    _movieCubit = getIt<MovieCubit>();
    _movieDetailsCubit = getIt<MovieDetailsCubit>();
    _movieCubit.getUpcomingMovies(
        apiUrl:
        'http://api.themoviedb.org/3/movie/upcoming?api_key=caebc202bd0a26f84f4e0d986beb15cd');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailsCubit, MovieDetailsState>(
      bloc: _movieDetailsCubit,
      listener: (context, state) {
        if (state is MovieDetailFetched) {
          final movieDetailModel = state.movieDetailsModel;
          context.router.pop();
          context.router.push(MovieDetailRoute(movieDetailsModel: movieDetailModel));
          // Navigator.of(context).push(
          //   CupertinoPageRoute(
          //     builder: (context) =>
          //         MovieDetailScreen(movieDetailsModel: state.movieDetailsModel),
          //   ),
          // );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions:  <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            )
          ],
          toolbarHeight: 60,
          backgroundColor: Colors.purple,
          elevation: 100,
          title: const Text('Movie App',),
        ),
        body: Center(
          child: Column(
            children: [
              // const Text('Movie initial screen'),
              Expanded(
                child: BlocBuilder<MovieCubit, MovieState>(
                    bloc: _movieCubit,
                    builder: (context, state) {
                      if (state is MovieFetched) {
                        return MovieListWidget(
                          movieFetched: state,
                          onClick: (int movieId) {
                            _movieDetailsCubit.getMovieDetails(movieId: movieId);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//BlocProvider
//BlocBuilder
//BlocListener
//BlocConsumer
//BlocSelector
//MultiBlocListener
//MultiBlocProvider

//dio package
// auto_route

void setAppBarTitle(){
  PreferenceUtils.setString('titleBarKey', 'CHICKEN BIRYANI');
}