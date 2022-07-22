import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {


  List<WorldTime> locations = [
    WorldTime(myurl: 'Asia/Kolkata', location: 'New Delhi / India', flag: 'india.jpeg'),
    WorldTime(myurl: 'Asia/Dubai', location: 'Muscat / Oman', flag: 'oman.jpeg'),
    WorldTime(myurl: 'Europe/London', location: 'London / UK', flag: 'uk.png'),
    WorldTime(myurl: 'Europe/Athens', location: 'Athens / Greece', flag: 'greece.png'),
    WorldTime(myurl: 'Africa/Cairo', location: 'Cairo / Egypt', flag: 'egypt.png'),
    WorldTime(myurl: 'Africa/Nairobi', location: 'Nairobi / Kenya', flag: 'kenya.png'),
    WorldTime(myurl: 'America/Chicago', location: 'Chicago / USA', flag: 'usa.png'),
    WorldTime(myurl: 'America/New_York', location: 'New York / USA', flag: 'usa.png'),
    WorldTime(myurl: 'Asia/Seoul', location: 'Seoul / South Korea', flag: 'south_korea.png'),
    WorldTime(myurl: 'Asia/Jakarta', location: 'Jakarta / Indonesia', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // navigate to home screen

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime' : instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
