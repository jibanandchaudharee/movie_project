import 'package:dio/dio.dart';
import 'package:movie_project/core/constants.dart';
import 'package:movie_project/feature/counter/data/models/movie_card_model.dart';
import 'package:movie_project/feature/counter/data/models/movie_details_model.dart';
import 'package:movie_project/main.dart';

/// Data source where all the api calls are handled

class MovieDataSourceImpl implements MovieDataSource {
  /// initializing dio client
  /// when the object of MovieDataSource is created
  MovieDataSourceImpl() {
    _dioClient = getIt<Dio>();
  }

  late Dio _dioClient;

  /// Fetch api using dio client' get method
  @override
  Future<List<MovieCardModel>> fetchUpcomingMovies(
      {required String upcomingMovies}) async {
    /// initializing empty map of json
    Map<String, dynamic> json = {};

    /// initializing empty list of MovieCardModel
    List<MovieCardModel> movieCardModels = [];

    /// getting the api response whose type is Response<Map<String, dynamic>>
    final Response<Map<String, dynamic>> jsonResponse =
    await _dioClient.get(upcomingMovies);

    /// checking if api json is not null
    if (jsonResponse.data != null) {
      json = jsonResponse.data!;
    }

    /// Looping through a list of results-key in a api json
    for (var result in json['results']) {
      final MovieCardModel movieCard = MovieCardModel.fromJson(result);
      movieCardModels.add(movieCard);
    }

    return movieCardModels;
  }

  Future<MovieDetailsModel?> fetchMovieDetails({required int movieId}) async {
    MovieDetailsModel? movieDetailsModel;
    final Response<
        Map<String,
            dynamic>> movieDetailResponse = await _dioClient.get(
        '${MovieConstants.baseUrl}/$movieId?api_key=${MovieConstants.key}&language=en-US');

    final Map<String, dynamic>? movieJson = movieDetailResponse.data;

    if (movieJson != null) {
      movieDetailsModel = MovieDetailsModel.fromJson(movieJson);
    }
    return movieDetailsModel;
  }

  @override
  void searchMovie({required String query}) async{
    final String searchApiPath = '${MovieConstants.movieSearchUrl}query=$query';
    final Response<Map<String,dynamic>>response =
          await _dioClient.get(searchApiPath);
    //print("Search movie ${response.data}");
  }
}


abstract class MovieDataSource {
  Future<List<MovieCardModel>> fetchUpcomingMovies(
      {required String upcomingMovies});


  searchMovie({required String query});
}
