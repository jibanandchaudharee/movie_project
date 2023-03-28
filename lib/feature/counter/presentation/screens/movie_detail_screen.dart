import 'package:flutter/material.dart';
import 'package:movie_project/core/utils/shared_pref.dart';
import 'package:movie_project/feature/counter/data/models/movie_details_model.dart';


class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.movieDetailsModel})
      : super(key: key);

  final MovieDetailsModel movieDetailsModel;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  String appBarTitle='';
  @override
  void initState() {
    super.initState();
    appBarTitle= getAppBarTitle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(widget.movieDetailsModel.title),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Row(
                children: <Widget>[
                  SizedBox(
                      height: 180,
                      child: Image.network('https://image.tmdb.org/t/p/w500/yJdeWaVXa2se9agI6B4mQunVYkB.jpg')
                  ),
                  Expanded(                  // Add from this line
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Ip Man 4: The Finale',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          SizedBox(height: 10),
                          Expanded(child: Text('Following the death of his wife, Ip Man travels to San Francisco to ease tensions between the local kung fu masters and his star student, Bruce Lee, while searching for a better future for his son.'))
                        ],
                      ),
                    ),
                  )               // To this line
                ],
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(widget.movieDetailsModel.overview),
          )
        ],
      ),
    );
  }
}


String getAppBarTitle(){
  return PreferenceUtils.getString('titleBarKey', "Set our default value");
}