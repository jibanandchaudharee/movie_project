class MovieConstants {
  MovieConstants._internal();
  static const String  key = 'caebc202bd0a26f84f4e0d986beb15cd';
  static String baseUrl = 'https://api.themoviedb.org/3/movie';
//static String movieDetailUrl = '$baseUrl?api_key=$key&sort_by=popularity.desc&with_genres=$genreId';
//static String movieDetailUrl = '$baseUrl/$movieID?api_key=$key&language=en-US';
  static const kThemovieDiscoverdbURL =
      "https://api.themoviedb.org/3/discover/movie";
  static const kThemoviedbSearchURL =
      "https://api.themoviedb.org/3/search/movie";

  static const String movieSearchUrl =
      '$kThemoviedbSearchURL/?api_key=$key&language=en-US&page=1&include_adult=false';


}
