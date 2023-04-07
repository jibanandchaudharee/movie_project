import 'package:auto_route/auto_route.dart';
import 'package:movie_project/core/router.gr.dart';
import 'package:movie_project/feature/counter/presentation/screens/movie_search_screen.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter{

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: MovieHomeRoute.page,path: '/'),
    AutoRoute(page: MovieDetailRoute.page, path: '/movieDetailRoute'),
    AutoRoute(page: MovieSearchRoute.page, path: '/movieSearchRoute'),


  ];
}
