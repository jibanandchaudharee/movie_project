import 'package:auto_route/auto_route.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project/core/router.gr.dart';
import 'package:movie_project/core/utils/hive_storage.dart';
import 'package:movie_project/core/utils/shared_pref.dart';
import 'package:movie_project/feature/counter/presentation/blocs/movie_cubit/movie_cubit.dart';
import 'package:movie_project/feature/counter/presentation/blocs/movie_cubit/movie_details_cubit/movie_details_cubit.dart';
//import 'package:movie_project/feature/counter/presentation/screens/movie_search_screen.dart';
import 'package:movie_project/feature/counter/presentation/widgets/movie_list_widgets.dart';
import 'package:movie_project/main.dart';

//import 'movie_detail_screen.dart';

@RoutePage()
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> with SingleTickerProviderStateMixin {
  late MovieCubit _movieCubit;
  late MovieDetailsCubit _movieDetailsCubit;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController= TabController(length: 3, vsync: this);
    // setAppBarTitleFromSharePref();
    setAppBarTitleFromHive();
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

          ///Auto Route
          context.router.pop();
          //context.router.push(MovieDetailRoute(movieDetailsModel: movieDetailModel));
          context.router.push(const MovieSearchRoute());
          // Navigator.of(context).push(
          //   CupertinoPageRoute(
          //     builder: (context) =>
          //         MovieDetailScreen(movieDetailsModel: state.movieDetailsModel),
          //   ),
          // );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "WATCH NOW",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          context.router.push(const MovieSearchRoute());
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'Popular',
                    ),
                    Tab(
                      text: 'Coming Soon',
                    ),
                    Tab(
                      text: 'Top Rated',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // appBar: AppBar(
        //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        //   flexibleSpace: Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       const SizedBox(
        //         height: 100,
        //       ),
        //       TabBar(
        //         controller: _tabController,
        //         tabs: const [
        //           Tab(
        //             text: 'Popular',
        //           ),
        //           Tab(
        //             text: 'Coming Soon',
        //           ),
        //           Tab(
        //             text: 'Top Rated',
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
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
            const Text("TAB2 "),
            const Text("TAB3")
          ],
        ),
      ),
    );
  }
}
      // child: DefaultTabController(
      //   length: 3,
      //   child: Scaffold(
      //     appBar: AppBar(
      //         bottom: const TabBar(
      //           //controller: _tabController,
      //           tabs: [
      //             Tab(
      //               text: 'Popular',
      //             ),
      //             Tab(
      //               text: 'Coming Soon',
      //             ),
      //             Tab(
      //               text: 'Top Rated',
      //             ),
      //           ],
      //         )),
      //     body:  TabBarView(
      //        children: [
      //          Center(
      //           child: Column(
      //             children: [
      //
      //             //const Text('Movie initial screen'),
      //               Expanded(
      //                 child: BlocBuilder<MovieCubit, MovieState>(
      //                     bloc: _movieCubit,
      //                     builder: (context, state) {
      //                       if (state is MovieFetched) {
      //                        return MovieListWidget(
      //                           movieFetched: state,
      //                           onClick: (int movieId) {
      //                             _movieDetailsCubit.getMovieDetails(movieId: movieId);
      //                              showDialog(
      //                                context: context,
      //                               builder: (context) {
      //                                 return const AlertDialog(
      //                                    content: Center(
      //                                    child: CircularProgressIndicator(),
      //                                   ),
      //                                 );
      //                               },
      //                              );
      //                            },
      //                         );
      //                        }
      //                        return const Center(
      //                         child: CircularProgressIndicator(),
      //                       );
      //                     }),
      //               )
      //             ],
      //            ),
      //          ),
      //             const Text('Coming Soon'),
      //             const Text('Top Rated')
      //        ],
      //     ),
      //   ),
      // ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     actions:  <Widget>[
      //       IconButton(
      //         icon: const Icon(Icons.search),
      //         onPressed: () {},
      //       )
      //     ],
      //     toolbarHeight: 60,
      //     backgroundColor: Colors.purple,
      //     elevation: 100,
      //     title: const Text('Movie App',),
      //   ),
      //   body: Center(
      //     child: Column(
      //       children: [
      //
      //         // const Text('Movie initial screen'),
      //         Expanded(
      //           child: BlocBuilder<MovieCubit, MovieState>(
      //               bloc: _movieCubit,
      //               builder: (context, state) {
      //                 if (state is MovieFetched) {
      //                   return MovieListWidget(
      //                     movieFetched: state,
      //                     onClick: (int movieId) {
      //                       _movieDetailsCubit.getMovieDetails(movieId: movieId);
      //                       showDialog(
      //                         context: context,
      //                         builder: (context) {
      //                           return const AlertDialog(
      //                             content: Center(
      //                               child: CircularProgressIndicator(),
      //                             ),
      //                           );
      //                         },
      //                       );
      //                     },
      //                   );
      //                 }
      //                 return const Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               }),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
  //   );
  // }
//}

//BlocProvider
//BlocBuilder
//BlocListener
//BlocConsumer
//BlocSelector
//MultiBlocListener
//MultiBlocProvider

//dio package
// auto_route

void setAppBarTitleFromSharePref(){
  PreferenceUtils.setString('titleBarKey', 'CHICKEN BIRYANI');
}

void setAppBarTitleFromHive(){
  HiveUtils.setString('titleBarKey', 'OUR MOVIE APP FROM HIVE');
}