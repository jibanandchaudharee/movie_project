
import 'package:hive/hive.dart';

class HiveUtils {

   static Box? _ourDataBase;


   static initDb()async {
     // _ourDataBase = Hive.box('movieDB');
     _ourDataBase= await Hive.openBox('movieDB');

  }

  static setString(String key, String value){
    _ourDataBase?.put(key, value);
  }

   static String getString(String key){
     return _ourDataBase?.get(key);
   }
}
