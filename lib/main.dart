//import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'detailspage.dart';
import 'superhero_details.dart';
import 'superhero_details.dart';
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
  List<Superheros> allSuperheroes =
      []; // instead of returning the superheroes in fetchData, we will assign it to this List, so we can use it again during searching
  // doing so we wouldn't need to call the API again and again,

  bool searchResultsVisible = false;
  List<Superheros> searchResults = [];

  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  Future<bool> fetchData() async {
    // if allSuperheroes was set without any errors, fetchData will return true, otherwise it'll return an error
    try {
      var response = await http.get(API);
      var data = jsonDecode(response.body);

      List<Superheros> superHerosList = data.map<Superheros>((sup) {
        // converting Map to Superheroes class object
        return Superheros.fromJson(sup);
      }).toList();

      allSuperheroes = superHerosList; // this is important change

      return true;
    } catch (err) {
      return Future.error("Daya, kuch toh gadbad hai.");
    }
  }

  _handleSearch() {
    var searchQuery = _textEditingController.text.trim();
    print(searchQuery);
    if (searchQuery.length > 0) {
      // when search is submitted, check if the search string isn't empty
      // if not empty, we can do the search

      // do the searching

      print("doing search");

      searchResults = [];

      for (Superheros s in allSuperheroes) {
        if (s.name.toLowerCase().indexOf(RegExp(searchQuery.toLowerCase())) >
            -1) {
          searchResults.add(s);
        }
      }

      setState(() {
        searchResults =
            searchResults; //  above, we are setting searchResults to empty, and filling it with results but not using setState,
        // so that the app wont slow down,
        // after the search is done, update the UI with new values,
        // since we stored the results in the same variable we just set it to itself in setState, so the gridbuilder will run once again
        // with the new results
      });

      if (searchResultsVisible == false) {
        setState(() {
          searchResultsVisible = true;
        });
      }
    } else {
      // if the textbox value is empty, then hide the results
      if (searchResultsVisible) {
        // set visible to false only if it was previously true, makes it more efficient
        setState(() {
          searchResultsVisible = false;
        });
        _textEditingController.clear(); // clear the textbox
      }
    }
  }

  Icon searchIcon = Icon(Icons.search, color: Colors.black, size: 30);
  Widget titleText = Text(
    "Superhero App",
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
  );

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
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search..."),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        onEditingComplete: () {
                          _handleSearch(); // when the enter key is pressed on kyb
                        },
                        onChanged: (value) {
                          _handleSearch();
                        },
                      );
                    } else {
                      setState(() {
                        // hide the results when the clear button is clicked
                        searchResultsVisible = false;
                      });
                      _textEditingController.clear(); // clear the textbox

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
          child:
              // ternary operator, 👇
              //  condition ? ifTrue : ifFalse

              searchResultsVisible
                  ?
                  // 👇 this is selected if the searchResultsVisible is true, since it's in the isTrue section of ternary,
                  GridView.builder(
                      itemCount: searchResults.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Superheros superhero = searchResults[index];

                        return Padding(
                          padding: const EdgeInsets.all(0.6),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HeroDetails(
                                      superhero: superhero,
                                    ),
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
                                          image:
                                              NetworkImage(superhero.images.lg),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 170,
                                      child: Center(
                                        child: Text(
                                          superhero.name,
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
                      })
                  :
                  // 👇 this is selected if the searchResultsVisible is false
                  FutureBuilder<bool>(
                      future: fetchData(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error);
                        } else if (snapshot.hasData && snapshot.data) {
                          // since .data is bool, we can check if it's true

                          var totalItems = allSuperheroes.length;

                          return GridView.builder(
                              itemCount: totalItems,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                Superheros superhero = allSuperheroes[index];

                                return Padding(
                                  padding: const EdgeInsets.all(0.6),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HeroDetails(
                                              superhero: superhero,
                                            ),
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
                                                borderRadius:
                                                    new BorderRadius.all(
                                                  const Radius.circular(8.0),
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      superhero.images.lg),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              width: 170,
                                              child: Center(
                                                child: Text(
                                                  superhero.name,
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
}
