import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_project/feature/counter/data/models/movie_card_model.dart';
import 'package:movie_project/feature/counter/data/repository/movie_repository.dart';
import 'package:movie_project/main.dart';


part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  final MovieRepository _movieRepository = getIt<MovieRepository>();

  /// calls [_movieRepository] methods passing the  [url]
  void getUpcomingMovies(
      {required String apiUrl}) async {
    final moviesData=  await _movieRepository.getUpcomingMovies(url: apiUrl);
    emit(MovieFetched(moviesData));
  }


}
