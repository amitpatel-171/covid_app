// ignore_for_file: invalid_required_positional_param

import 'package:covid_app/view/world_stats.dart';
import 'package:flutter/material.dart';

class DEtailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      totadyRecovered,
      active,
      critical,
      test;
  DEtailScreen({
    required this.name,
    required this.active,
    required this.totadyRecovered,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.image,
    required this.critical,
    required this.test,
  });

  @override
  State<DEtailScreen> createState() => _DEtailScreenState();
}

class _DEtailScreenState extends State<DEtailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.67),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Reuseable(
                          title: "Cases", value: widget.totalCases.toString()),
                      Reuseable(
                          title: "Active Cases",
                          value: widget.active.toString()),
                      Reuseable(
                          title: "Recovered Today",
                          value: widget.totadyRecovered.toString()),
                      Reuseable(
                          title: "Critical",
                          value: widget.totalDeaths.toString()),
                      Reuseable(
                          title: "Total Recovered",
                          value: widget.totalRecovered.toString()),
                      Reuseable(
                          title: "Cases", value: widget.totalCases.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
