import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/Model/MyClipper.dart';
import 'package:covid19/Model/CardWidget.dart';

List _countries = List();
var totalCases, population, deaths, todayCases, todayDeaths;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String current;
  void fetchdata() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries');
    final countries = json.decode(response.body);
    setState(() {
      _countries = countries;
    });
  }

  getTotalCases(current) async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries/${current}');
    final data = json.decode(response.body);
    setState(() {
      totalCases = data['cases'];
      population = data['population'];
      deaths = data['deaths'];
      todayCases = data['todayCases'];
      todayDeaths = data['todayDeaths'];
      if (totalCases.toString().length > 3) {
        totalCases = totalCases / 1000;
        totalCases = totalCases.toString() + " k";
      }
      if (deaths.toString().length > 3) {
        deaths = deaths / 1000;
        deaths = deaths.toString() + " k";
      }
      if (todayCases != 0) {
        todayCases = todayCases.toString() + " +";
      }
      if (todayDeaths != 0) {
        todayDeaths = todayDeaths.toString() + " +";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(left: 40, top: 50, right: 20),
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/virus.png')),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 122, top: 62),
                        child: new Text(
                          "All you need \n is stay at home",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xFFE5E5E5),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.location_on_outlined),
                ),
                Center(
                  child: new DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      value: current,
                      hint: new Text("Choose country"),
                      items: _countries?.map((value) {
                            return new DropdownMenuItem(
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    value['countryInfo']['flag'],
                                    width: 22,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(value['country']),
                                ],
                              ),
                              value: value['country'].toString(),
                            );
                          }).toList() ??
                          [],
                      onChanged: (newValue) {
                        setState(() {
                          current = newValue;
                          getTotalCases(current);
                        });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  myCard(
                      belowText: "Cases",
                      data: totalCases.toString(),
                      textColor: Colors.orange[700]),
                  myCard(
                      belowText: "Deaths",
                      data: deaths.toString(),
                      textColor: Colors.red),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  myCard(
                      belowText: "Today Cases",
                      data: todayCases.toString(),
                      textColor: Colors.orange[700]),
                  myCard(
                      belowText: "Today deaths",
                      data: todayDeaths.toString(),
                      textColor: Colors.red
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 26,),
          Center(
            child: Text(
              "Made by Jayant Saksham with ❤️",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
