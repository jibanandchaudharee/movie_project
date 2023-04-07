
import 'package:movie_project/feature/counter/data/data_source/movie_data_source.dart';
import 'package:movie_project/feature/counter/data/models/movie_card_model.dart';
import 'package:movie_project/feature/counter/data/models/movie_details_model.dart';

/// calls the appropriate datasource
/// and its related method calls
class MovieRepository {
  MovieRepository(this._movieDataSource);

  late final MovieDataSourceImpl _movieDataSource;

  /// calls [_movieDataSource] methods passing the  [url]
  Future<List<MovieCardModel>> getUpcomingMovies({required String url}) async {
    return await _movieDataSource.fetchUpcomingMovies(upcomingMovies: url);
  }

  Future<MovieDetailsModel?> getMovieDetails({required int movieId}) async{

    return await _movieDataSource.fetchMovieDetails(movieId:movieId);

  }

  void searchMovie({required String queryFromCubit})async {

    _movieDataSource.searchMovie(query:queryFromCubit);
  }
}
