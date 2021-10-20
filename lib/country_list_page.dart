import 'dart:collection';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:async";

import 'package:region_app_demo/region_selection_page.dart';

class CountryListPage extends StatefulWidget {
  final String? regionName;
  const CountryListPage({Key? key, this.regionName}) : super(key: key);

  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  List<bool>? showColor = [];
  List<dynamic>? data;

  Future<List<dynamic>?>? fetchData() async {
    var url =
        Uri.parse('https://restcountries.com/v3.1/region/${widget.regionName}');
    final result = await http.Client().get(url);
    if (json.decode(result.body) != null) {
      data = (json.decode(result.body));
    }
    return data;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0)),
                child: FutureBuilder<List<dynamic>?>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // print(snapshot.data);
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, index) {
                            showColor!.add(false);

                            print(showColor);
                            String? countryName =
                                snapshot.data![index]["name"]['common'];
                            String? shortNameOfCountry =
                                snapshot.data![index]['cca3'];
                            String? capitalOfTheCountry;
                            if (snapshot.data![index]['capital'] != null) {
                              capitalOfTheCountry =
                                  snapshot.data![index]['capital'][0];
                            } else {
                              capitalOfTheCountry = "";
                            }
                            int? populationOfTheCountry =
                                (snapshot.data![index]['population']);
                            String? flagOfTheCountry =
                                snapshot.data![index]['flags']['png'];
                            String? demonymOfThePeople =
                                snapshot.data![index]['demonyms']['eng']['f'];
                            String? currencyOfTheCountry;

                            String? dialingCode = snapshot.data![index]['idd']
                                    ['root'] +
                                snapshot.data![index]['idd']['suffixes'][0];
                            LinkedHashMap? currencies =
                                snapshot.data![index]['currencies'];
                            for (var currency in currencies!.values) {
                              if (currency != null) {
                                currencyOfTheCountry =
                                    currency['symbol'] + " " + currency['name'];
                              }
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: MaterialButton(
                                  child: Text(countryName!,
                                      style: TextStyle(color: Colors.white)),
                                  color: showColor![index] == true
                                      ? Colors.indigo
                                      : Colors.indigo.withOpacity(0.5),
                                  onPressed: () {
                                    setState(() {
                                      showColor![index] = true;
                                    });
                                    showModalBottomSheet(
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    child: Column(
                                                      children: [
                                                        //title
                                                        Center(
                                                            child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.1),
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              Colors.black,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: widget
                                                                              .regionName ==
                                                                          "asia"
                                                                      ? Text(
                                                                          "Asia/$countryName")
                                                                      : Text(
                                                                          "Europ/$countryName"),
                                                                ))),

                                                        //first row
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              //flag of the country
                                                              Image.network(
                                                                flagOfTheCountry!,
                                                                height: 30,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      countryName),
                                                                  //capital of the country
                                                                  Text(
                                                                      capitalOfTheCountry!),
                                                                ],
                                                              ),

                                                              //currency of the country
                                                              Text(
                                                                  shortNameOfCountry!),
                                                            ],
                                                          ),
                                                        ),
                                                        //second row
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      'Demonym',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black38)),
                                                                  //natinality of country
                                                                  Text(
                                                                      demonymOfThePeople!),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      'Calling Code',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black38)),
                                                                  //calling code of the counrty
                                                                  Text(
                                                                      dialingCode!),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        //third Row
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  //currency of the country
                                                                  Text(
                                                                      "Currency",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black38)),
                                                                  Text(
                                                                      currencyOfTheCountry!),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      'Population',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black38)),
                                                                  //population
                                                                  Text(populationOfTheCountry
                                                                      .toString())
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 10,
                                                child: ConstrainedBox(
                                                  constraints:
                                                      BoxConstraints.tightFor(
                                                          width: 50,
                                                          height: 50),
                                                  child: ElevatedButton(
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        showColor![index] =
                                                            false;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.indigo,
                                                      shape: CircleBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 50, height: 50),
            child: ElevatedButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegionSelectionPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                shape: CircleBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
