//import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'detailspage.dart';
import 'superhero_details.dart';

const API = "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var superhero;
  var superHeroName;
  bool searchVisible;
  List<Superheros> searchResults = [];
  Icon searchIcon = Icon(Icons.search, color: Colors.black, size: 30);
  Widget titleText = Text(
    "Superhero App",
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
  );

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> fetchData() async {
    var response = await http.get(API);
    var data = jsonDecode(response.body);

    // data is an array of Maps. so loop through it and make an Array of the class Superheros objects,
    // use it's fromJson method to do it.

    // List<Superheros> superHerosList = data.map( (sup) { return SuperHeros.fromJson(sup); } ).toList();

    // and return that final List. When Doing that, the return type of this function would become,
    // Future<List<Superheros>>
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white30,
          actions: <Widget>[
            IconButton(
                icon: searchIcon,
                onPressed: () {
                  setState(() {
                    if (this.searchIcon.icon == Icons.search) {
                      this.searchIcon = Icon(Icons.cancel, color: Colors.black);
                      this.titleText = TextField(
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search..."),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        onChanged: (text) {
                          text = text.toLowerCase();
                          setState(() {
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: searchVisible
                                    ? searchResults.length
                                    : superhero.length,
                                itemBuilder:
                                    ((BuildContext context, int index) {
                                  if (searchVisible) {
                                    return Card(
                                      child: Text(searchResults[index].name),
                                    );
                                  } else {
                                    return Card(child: Text("j"));
                                  }
                                }));
                          });
                        },
                      );
                    } else {
                      this.searchIcon =
                          Icon(Icons.search, color: Colors.black, size: 30);
                      this.titleText = Text(
                        "Superhero App",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      );
                    }
                  });
                })
          ],
          title: titleText,
          elevation: 0.0,
        ),
        body: Center(
          child: FutureBuilder(
              future: fetchData(),
              builder: (_, snapshot) {
                // first check for errors.

                if (snapshot.hasError) {
                  return Text("error");
                } else if (snapshot.hasData) {
                  // next display the data if there are no errors.
                  var totalItems = snapshot.data.length;
                  return GridView.builder(
                      itemCount: totalItems,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        superhero = snapshot.data[index];
                        // individual superhero data.
                        // You should loop through this
                        // and use the fromJson() method of your model
                        // to convert it to object in the fetchData() itself,

                        var superHeroImage = superhero["images"]["lg"];
                        superHeroName = superhero["name"];
                        Map<dynamic, dynamic> appearance = {
                          "superHerogender": superhero["appearance"]["gender"],
                          "superHeroRace": superhero["appearance"]["race"],
                          "superHeroHeight": superhero["appearance"]["height"],
                          "superHeroWeight": superhero["appearance"]["weight"],
                          "superHeroEyecolor": superhero["appearance"]
                              ["eyeColor"],
                          "superHeroHaircolor": superhero["appearance"]
                              ["hairColor"],
                        };
                        Map<dynamic, dynamic> biography = {
                          "fullName": superhero["biography"]["fullName"],
                          "placeOfBirth": superhero["biography"]
                              ["placeOfBirth"],
                          "publisher": superhero["biography"]["publisher"],
                          "alignment": superhero["biography"]["alignment"],
                        };
                        Map<dynamic, dynamic> powerstats = {
                          "intelligence": superhero["powerstats"]
                              ["intelligence"],
                          "strength": superhero["powerstats"]["strength"],
                          "speed": superhero["powerstats"]["speed"],
                          "power": superhero["powerstats"]["power"],
                          "combat": superhero["powerstats"]["combat"],
                        };
                        Map<dynamic, dynamic> connections = {
                          "groupAffiliation": superhero["connections"]
                              ["groupAffiliation"],
                          "relatives": superhero["connections"]["relatives"],
                        };

                        return Padding(
                          padding: const EdgeInsets.all(0.6),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HeroDetails(
                                        superhero: superhero,
                                        superHeroName: superHeroName,
                                        superHeroImage: superHeroImage,
                                        appearance: appearance,
                                        biography: biography,
                                        powerstats: powerstats,
                                        connections: connections),
                                  ));
                            },
                            child: Hero(
                              tag: superhero,
                              child: Card(
                                margin: EdgeInsets.all(3),
                                elevation: 3.0,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 145,
                                      width: 163,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.all(
                                          const Radius.circular(8.0),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(superHeroImage),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 170,
                                      child: Center(
                                        child: Text(
                                          superHeroName,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  detailspage({superhero}) {}
}
