import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_project/feature/counter/data/data_source/movie_data_source.dart';
import 'package:movie_project/feature/counter/data/models/movie_details_model.dart';
import 'package:movie_project/feature/counter/data/repository/movie_repository.dart';
import 'package:movie_project/main.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  final MovieRepository _movieRepository = getIt<MovieRepository>();

  void getMovieDetails({required int movieId})async{
    final movieDetails =
    await _movieRepository.getMovieDetails(movieId: movieId);

    if(movieDetails!=null){
      emit(MovieDetailFetched(movieDetails));
    }
  }
}
