import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map map = {};
  @override
  Widget build(BuildContext context) {
    map = (!map.isEmpty) ?map : ModalRoute.of(context)?.settings.arguments as Map ;
    print(map);
    String bg = map['isDay'] ? 'day.png' : 'night.png';
    Color? color = map['isDay'] ? Colors.blue[900] : Colors.pink[300];
    return Scaffold(
      backgroundColor: color,
      body:SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bg'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 128.0, 0, 0),
          child: Column(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async{
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    map['location'] = result['location'];
                    map['flag'] = result['flag'];
                    map['time'] = result['time'];
                    map['isDay'] = result['isDay'];
                  });
                },
                icon: Icon(Icons.location_on_outlined),
                label: Text(
                    'Choose Location',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: color,
                )
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    map['location'],
                    style: TextStyle(
                      fontSize: 33.0,
                      letterSpacing: 2.0,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                map['time'],
                style: TextStyle(
                  fontSize: 66.0,
                ),
              )
            ],
          ),
      ),
        ),
      )
    );
  }
}
