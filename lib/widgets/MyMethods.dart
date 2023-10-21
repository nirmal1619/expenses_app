import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../expense/expense.dart';
import 'tStructure.dart';

class MyMethods{


static Color MainColor=Colors.teal.shade400;
static Color lastColor=MainColor;
// static Color MainColor=Colors.deepPurple.shade900;
static Color Black=Colors.white;
static Color Wlack=Colors.white;
static double maxAmount=10000;
static  double totalExpense=0;
static double percentage=0;
static double reset=10000;
static double usePercentage=0;
static int expenseNumber=0;
static double food=0,travel=0,movie=0,rent=0,electronics=0;
static bool isDark=false;

static ByCatagaryExpense(Category catagary,double MoneyOfCatagary){
  if(catagary==Category.food){
    food=food+MoneyOfCatagary;
    print("food $food");
  }
  if(catagary==Category.travel){
    travel=travel+MoneyOfCatagary;
    print("travel $travel");
  }
  if(catagary==Category.rent){
   rent=rent+MoneyOfCatagary;
 print("Rent $rent");
  }
  if(catagary==Category.movie){
    movie=movie+MoneyOfCatagary;
    print("movie= $movie");
  }
  if(catagary==Category.electronic){
    electronics=electronics+MoneyOfCatagary;
    print("electronic = $electronics");
  }
}


static ShowSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: TStructure(text: message, tColor: MainColor, tSize: 15),
      duration: Duration(seconds: 2),
      action: SnackBarAction(label: "Edit", onPressed: () {}, textColor: MainColor),
    ),

  );
}


static SliverAppBar SAppBar(
{
  required Function onIconPressed,
  required BuildContext context
}
    ){
  return SliverAppBar(
    stretch: true,
    centerTitle: true,
    // systemOverlayStyle: ,
    backgroundColor: MyMethods.MainColor, // Replace with MyMethods.MainColor
    title: Text("KhaTa",style: TextStyle(color: Colors.white),),
    leading: Icon(Icons.calculate,color: Colors.white,),
    expandedHeight: 200,
    floating: false, // Set to false to prevent it from shrinking immediately.
    pinned: false,
    actions: [
      IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text("Select Theme"),
              content: Text("Choose a theme for the app."),
              actions: [
                CupertinoDialogAction(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCircularButton(Colors.red.shade200, onIconPressed),
                          _buildCircularButton(Colors.pink.shade200, onIconPressed),
                          _buildCircularButton(Colors.orange.shade400, onIconPressed),
                          _buildCircularButton(Colors.cyan.shade400, onIconPressed),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCircularButton(Colors.blue.shade400, onIconPressed),
                          _buildCircularButton(Colors.amber.shade400, onIconPressed),
                          _buildCircularButton(Colors.teal.shade400, onIconPressed),
                          _buildCircularButton(Colors.indigo.shade400, onIconPressed),


                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        icon: Icon(
          CupertinoIcons.paintbrush,
          color: Colors.white,
        ),
      ),

      IconButton(onPressed: (){


        isDark=!isDark;

        if(!isDark){
          // MyMethods.MainColor=Colors.deepPurple.shade900;

          MyMethods.MainColor=lastColor;
        }
        else{
          MyMethods.lastColor=MyMethods.MainColor;
          MyMethods.MainColor=Colors.black.withOpacity(0.7);
        }
        onIconPressed();
      },
        color: Colors.white,
        icon: isDark
            ? Icon(CupertinoIcons.sun_min)// Moon icon for dark mode
            : Icon(CupertinoIcons.moon), // Sun icon for light mode

      )
 // Sun icon for light mode)
    ],
    flexibleSpace: FlexibleSpaceBar(
      stretchModes: [
        StretchMode.zoomBackground
      ],
      background: Container(
        padding: EdgeInsets.only(top: 70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 20.0,
              percent: percentage,
              progressColor: percentage > 0.7 ? Colors.red.shade900 : MyMethods.MainColor, // Replace with MyMethods.MainColor
              backgroundColor: Colors.white,
              animation: true,


              center: Text(usePercentage.toStringAsFixed(2) + "%",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),

              animationDuration: 1500,
              curve: Curves.easeInBack,
              backgroundWidth: 23.2,

              circularStrokeCap: CircularStrokeCap.butt,
            ),

            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: MyMethods.MainColor, // Replace with MyMethods.MainColor
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Card(
                elevation: 19,
                color: MyMethods.MainColor, // Replace with MyMethods.MainColor
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Expense",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6), // Add space between label and value
                          Text(
                            "MAx Limit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6), // Add space between label and value
                          Text(
                            "Rest Money",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            totalExpense.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6), // Add space between label and value
                          Text(
                            maxAmount.toString(),

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6), // Add space between label and value
                          Text(
                            reset.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
}
Widget _buildCircularButton(Color themeColor, Function onPressed) {
  return GestureDetector(
    onTap: () {
      if(themeColor!=null){

        MyMethods.MainColor=themeColor;

      }
      else{
        print("null");
      }


      onPressed(); // Call the provided function when the button is tapped
    },
    child: Container(

      margin: EdgeInsets.all(8),
      width: 60, // Adjust the size as needed
      height: 60, // Adjust the size as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: themeColor,
      ),
    ),
  );
}

