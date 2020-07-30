import 'dart:ui';

import 'package:flutter/material.dart';
import 'superhero_details.dart';
import 'main.dart';
import 'package:flip_card/flip_card.dart';

class HeroDetails extends StatefulWidget {
  final superhero;
  final superHeroName;
  final superHeroImage;
  final Map<dynamic, dynamic> appearance;
  final Map<dynamic, dynamic> biography;
  final Map<dynamic, dynamic> powerstats;
  final Map<dynamic, dynamic> connections;

  HeroDetails(
      {this.superhero,
      this.superHeroName,
      this.superHeroImage,
      this.appearance,
      this.biography,
      this.powerstats,
      this.connections});

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(this.context);
            // do something
          },
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery.of(context).size.height / 1.40,
              width: MediaQuery.of(context).size.width - 20,
              left: 10.0,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Name:${widget.superHeroName}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: <Widget>[
                            appearance(),
                            biography(),
                            powerstats(),
                            groupAffiliation(),
                            connections()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                  tag: widget.superhero,
                  child: Container(
                    height: 120.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(8.0)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.superHeroImage)),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  appearance() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Appearence',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        back: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "Gender: ${widget.appearance["superHerogender"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  //onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "Race: ${widget.appearance["superHeroRace"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "Height: ${widget.appearance["superHeroHeight"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "Weight: ${widget.appearance["superHeroWeight"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "EyeColor: ${widget.appearance["superHeroEyecolor"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  //onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "HaiColor: ${widget.appearance["superHeroHaircolor"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  //  onSelected: (b) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  biography() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Biography',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        back: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: Column(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "FullName: ${widget.biography["fullName"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  //onSelected: (b) {},
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "PlaceOfBirth: ${widget.biography["placeOfBirth"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "Publisher: ${widget.biography["publisher"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "alignment: ${widget.biography["alignment"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  powerstats() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Powerstats',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        back: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "intelligence: ${widget.powerstats["intelligence"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  //onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "speed: ${widget.powerstats["speed"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "power: ${widget.powerstats["power"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "combat: ${widget.powerstats["combat"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
              Flexible(
                child: Container(
                  height: 36,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink[200]),
                  child: Text(
                    "strength: ${widget.powerstats["strength"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  // onSelected: (b) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  groupAffiliation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
          direction: FlipDirection.HORIZONTAL, // default
          front: Container(
            height: 290,
            width: 220,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'GroupAffiliation',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          back: Container(
            height: 290,
            width: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            child: Flexible(
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: 36,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.pink[200]),
                      child: Text(
                        "Connection",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      // onSelected: (b) {},
                    ),
                  ),
                  Text(
                    "${widget.connections["groupAffiliation"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          )

          // onSelected: (b) {},
          ),
    );
  }

  connections() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(
              'Connections',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        back: Container(
          height: 290,
          width: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
          child: Flexible(
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 36,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.pink[200]),
                    child: Text(
                      "Connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    // onSelected: (b) {},
                  ),
                ),
                Text(
                  "${widget.connections["relatives"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
