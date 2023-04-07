import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project/feature/counter/presentation/blocs/movie_search%20cubit/movie_search_cubit.dart';

@RoutePage()
class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({Key? key}) : super(key: key);

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  late TextEditingController _textEditingController;
  late MovieSearchCubit _movieSearchCubit;

  @override
  void initState() {
    super.initState();
    _textEditingController= TextEditingController();
    //_searchQueryController= TextEditingController();
    _movieSearchCubit= MovieSearchCubit();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextFormField(
          controller: _textEditingController,
          decoration: const InputDecoration(hintText: 'Search Movie'),
          onSaved: (userInput){
            if(userInput!=null){
              _movieSearchCubit.searchMovie(queryFromUi: userInput);
            }
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        BlocBuilder<MovieSearchCubit,MovieSearchState>(
            bloc: _movieSearchCubit,
            builder: (context, state){
          if(state is MovieFetching){
            return const Center(child: CircularProgressIndicator(),);
          }
          return const Center(child: Text("You have not searched any movies yet"),);
        })
        ],
      ),
    );
  }

}
