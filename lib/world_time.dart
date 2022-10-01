import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location,flag,url,time = "";
  bool isDay = false;
  WorldTime({required this.location,required this.flag,required this.url});

    Future<void> getTime() async{
      try{
        Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

        //Decode Json string data to Map
        Map map = jsonDecode(response.body);

        //convert datetime to DateTime object
        DateTime dateTime = DateTime.parse(map['utc_datetime']);
        String offsetH = map['utc_offset'].toString().substring(1,3);
        String offsetM = map['utc_offset'].toString().substring(4,6);
        //print(dateTime);

        dateTime = dateTime.add(Duration(hours: int.parse(offsetH)));
        dateTime = dateTime.add(Duration(minutes: int.parse(offsetM)));
        //set time property
        isDay = (dateTime.hour > 6 && dateTime.hour < 20) ? true : false;
        this.time = DateFormat.jm().format(dateTime);

        print(time);

      }catch(e){
        print('Caught Error : $e');
        time = 'Can\'t get Data';
      }
  }
}