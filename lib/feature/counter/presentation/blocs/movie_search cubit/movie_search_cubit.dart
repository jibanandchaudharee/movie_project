import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_project/feature/counter/data/repository/movie_repository.dart';
import 'package:movie_project/main.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  //MovieSearchCubit() : super(MovieSearchInitial());
  MovieSearchCubit()
      :_movieRepository=getIt<MovieRepository>(),
        super(MovieSearchInitial());
  late final MovieRepository _movieRepository;

  void searchMovie({required String queryFromUi}){

    _movieRepository.searchMovie(queryFromCubit: queryFromUi);
  }
}
