import 'package:covid_app/model/world_stats_model.dart';
import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        FutureBuilder(
            future: statsServices.fetchWorldStatsRecords(),
            builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ));
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        // "Total": 50,
                        // "Recovered": 37,
                        // "Death": 13
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recovered":
                            double.parse(snapshot.data!.recovered.toString()),
                        "Death": double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left),
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.06),
                      child: Card(
                        child: Column(
                          children: [
                            Reuseable(
                              title: "Total",
                              value: snapshot.data!.cases.toString(),
                            ),
                            Reuseable(
                              title: "Recovered",
                              value: snapshot.data!.recovered.toString(),
                            ),
                            Reuseable(
                              title: "Deaths",
                              value: snapshot.data!.deaths.toString(),
                            ),
                            Reuseable(
                              title: "Active",
                              value: snapshot.data!.active.toString(),
                            ),
                            Reuseable(
                              title: "Critical",
                              value: snapshot.data!.critical.toString(),
                            ),
                            Reuseable(
                              title: "Today Deaths",
                              value: snapshot.data!.todayDeaths.toString(),
                            ),
                            Reuseable(
                              title: "Today Recovered",
                              value: snapshot.data!.todayRecovered.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CountriesList()));
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(122, 14, 107, 9)),
                        child: const Center(
                          child: Text(
                            "Track Countries",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
      ],
    )));
  }
}

class Reuseable extends StatelessWidget {
  String title, value;
  Reuseable({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
