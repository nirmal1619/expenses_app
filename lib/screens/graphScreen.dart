import 'package:expenses_app/widgets/MyMethods.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key, required this.onIconPressed});
  final Function onIconPressed;
  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  double highestValue = 0;
  double secondHighestValue = 0;
  double thirdHighestValue = 0;
  double fourthHighestValue = 0;
  double fifthValue = 0;

  void sortValues(double a, double b, double c, double d, double e) {
    List<double> values = [a, b, c, d, e];
    values.sort(); // Sort the values in ascending order

    highestValue = values[4];
    secondHighestValue = values[3];
    thirdHighestValue = values[2];
    fourthHighestValue = values[1];
    fifthValue = values[0];
  }

  Color sortColor(double x) {
    if (x == highestValue) {
      return MyMethods.MainColor.withOpacity(0.9);
    }

    if (x == secondHighestValue) {
      return MyMethods.MainColor.withOpacity(0.7);
    }

    if (x == thirdHighestValue) {
      return MyMethods.MainColor.withOpacity(0.5);
    }

    if (x == fourthHighestValue) {
      return MyMethods.MainColor.withOpacity(0.3);
    } else {
      return MyMethods.MainColor.withOpacity(0.1);
    }
  }

Color sortTittleColor(double x){
  if(x==highestValue){
    return Colors.white.withOpacity(01);
  //   titleStyle: TextStyle(color: Colors.white.withOpacity(01))
  }

  if(x==secondHighestValue){
    return Colors.white.withOpacity(1);
  }

  if(x==thirdHighestValue){
    return Colors.white.withOpacity(1);
  }

  if(x==fourthHighestValue){
    return MyMethods.MainColor.withOpacity(01);
  }
  else{
    return  MyMethods.MainColor.withOpacity(01);
  }
}


  @override
  void initState() {
    sortValues(
      MyMethods.food,
      MyMethods.rent,
      MyMethods.travel,
      MyMethods.movie,
      MyMethods.electronics,
    );
    super.initState();
  }
  void updateUi(){
    widget.onIconPressed();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          MyMethods.SAppBar(
              onIconPressed: updateUi,
              context: context,
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: true,
                    ),
                    centerSpaceRadius:
                    MediaQuery.of(context).size.width * 0.275,
                    sections: [
                      PieChartSectionData(
                        value: MyMethods.food,
                        color: sortColor(MyMethods.food),
                        showTitle: true,
                        title: "Food",
                        titleStyle: TextStyle(
                            color: sortTittleColor(MyMethods.food)),
                      ),
                      PieChartSectionData(
                        value: MyMethods.rent,
                        color: sortColor(MyMethods.rent),
                        title: "Rent",
                        titleStyle: TextStyle(
                            color: sortTittleColor(MyMethods.rent)),
                      ),
                      PieChartSectionData(
                        value: MyMethods.travel,
                        color: sortColor(MyMethods.travel),
                        title: "Travel",
                        titleStyle: TextStyle(
                            color: sortTittleColor(MyMethods.travel)),
                      ),
                      PieChartSectionData(
                        value: MyMethods.movie,
                        color: sortColor(MyMethods.movie),
                        title: "Movie",
                        titleStyle: TextStyle(
                            color: sortTittleColor(MyMethods.movie)),
                      ),
                      PieChartSectionData(
                        value: MyMethods.electronics,
                        color: sortColor(MyMethods.electronics),
                        title: "Electronics",
                        titleStyle: TextStyle(
                            color: sortTittleColor(MyMethods.electronics)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


