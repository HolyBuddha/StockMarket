import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tn_group_test/screens/details/details_screen.dart';
import '../../consts/constants.dart';
import 'components/indicator_widget.dart';
import 'home_repository/home_models.dart';
import 'home_repository/home_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  
  int touchedIndex = -1;
  List<CompanyInfo> companies = [];
  List<String> companiesSymbols = ['AAPL', 'AMZN', 'GOOG', 'MSFT', 'NFLX'];
  List<Color> sectionColors = [
    AppColors.colorRed,
    AppColors.colorYellow,
    AppColors.colorPurple,
    AppColors.colorBlue,
    AppColors.colorCyan,
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  homeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Market'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Total capitalization",
            style: TextStyle(fontSize: 30),
          ),
          Text('${totalCapitalization(companies)} billions'),
          const SizedBox(
            height: 30,
          ),
          AspectRatio(
            aspectRatio: 2,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                      openDetailsScreen(touchedIndex);
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 5,
                centerSpaceRadius: 50,
                sections: showingSections(companies),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: showingIndicators(companies),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              fetchData();
            },
            child: const Text(
              'Update',
              style: TextStyle(color: AppColors.colorWhite),
            ),
          )
        ],
      ),
    );
  }

  List<Indicator> showingIndicators(List<CompanyInfo> companies) {
    List<Indicator> result = [];
    if (companies.isNotEmpty) {
      for (int i = 0; i < companies.length; i++) {
        var section = Indicator(
          color: sectionColors[i],
          text: companies[i].name ?? "No data",
          isSquare: false,
          size: 10,
        );
        result.add(section);
      }
    }
    return result;
  }

  List<PieChartSectionData> showingSections(List<CompanyInfo> companies) {
    List<PieChartSectionData> result = [];

    for (int i = 0; i < companies.length; i++) {
      var section = PieChartSectionData(
        color: sectionColors[i],
        value: companies[i].marketCapitalization,
        title:
            ((companies[i].marketCapitalization ?? Capacity.bil) / Capacity.bil)
                .toStringAsFixed(1),
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.colorWhite,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
      result.add(section);
    }
    return result;
  }

  String totalCapitalization(List<CompanyInfo> companies) {
    var result = 0;

    for (int i = 0; i < companies.length; i++) {
      result = result + (companies[i].marketCapitalization ?? 0).round();
    }
    return (result / Capacity.bil).toStringAsFixed(1);
  }

  fetchData() async {
    try {
      companies = await HomeRepository().getAllCompaniesInfo(companiesSymbols);
      homeState();
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text('Ок'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  openDetailsScreen(int i) {
    if (i >= 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(
                    companyInfo: companies[i],
                  )));
    }
  }
}
