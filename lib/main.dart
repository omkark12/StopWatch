import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeappstate(),
    );
  }
}

class homeappstate extends StatefulWidget {
  const homeappstate({Key? key}) : super(key: key);

  @override
  State<homeappstate> createState() => _homeappstateState();
}

class _homeappstateState extends State<homeappstate> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitseconds = "00", digitminutes = "00", digithours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digithours = "00";
      digitminutes = "00";
      digitseconds = "00";
      started = false;
    });
  }

  void addlPS() {
    String lap = "$digithours:$digitminutes:$digitseconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localseconds = seconds + 1;
      int localminutes = minutes;
      int localhour = hours;
      if (localseconds > 59) {
        if (localminutes > 59) {
          localhour++;
          localminutes = 0;
        } else {
          localminutes++;
          localseconds = 0;
        }
      }
      setState(() {
        seconds = localseconds;
        minutes = localminutes;
        hours = localhour;
        digitseconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digithours = (hours >= 10) ? "$hours" : "0$hours";
        digitminutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'StopWatch ⏳',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 3),
              Image.asset(
                "img/stpw.png",
                width: 200,
                height: 200,
              ),
              SizedBox(height: 6),
              Center(
                child: Text(
                  '$digithours.$digitminutes.$digitseconds',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 6),
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "lap ${index + 1}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${laps[index]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.white)),
                      child: Text(
                        (!started) ? "start" : "pause",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        addlPS();
                      },
                      icon: Icon(Icons.flag)),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.white)),
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
