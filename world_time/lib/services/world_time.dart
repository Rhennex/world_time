import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location of the UI
  String time = "";// time of the above location
  String flag; // url to asset flag icon
  String myurl; // location url to make request

  late bool isDaytime ; // true or false

  WorldTime({required this.location, required this.flag, required this.myurl});

  Future<void> getTime() async {

    String url ='https://worldtimeapi.org/api/timezone/$myurl';

    //request for time
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(data);

    // Get datetime and offset from data

    String datetime = data['datetime'];
    String offset_type = data['utc_offset'].substring(0,1); // to know if we need to add or subtract to timezone
    String offset = data['utc_offset'].substring(1,3); // to get the hours to be add/subtract
    String offset_min = data['utc_offset'].substring(4,6); // to get the minutes to add/subtract
    // print (offset_type);
    // print(offset_min);
    // print(datetime);
    // print(offset);

    // make a Date_time object

    DateTime now = DateTime.parse(datetime);

    if(offset_type == '+') {
      now = now.add(Duration(hours: int.parse(offset)));
      now = now.add(Duration(minutes: int.parse(offset_min)));
    } else if(offset_type == '-'){
      now = now.subtract(Duration(hours: int.parse(offset)));
      now = now.subtract(Duration(minutes: int.parse(offset_min)));
    } else {}

    // print(now);

    isDaytime = now.hour>6 && now.hour<19 ? true : false;
    time = DateFormat.jm().format(now);
  }


}