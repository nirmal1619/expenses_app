import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'screens/addExpenseScreen.dart';
import 'screens/expenseListScreen.dart';
import 'screens/graphScreen.dart';
import 'screens/settingScreen.dart';
import 'widgets/MyMethods.dart';

class BottomNaviBar extends StatefulWidget {
  BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  double totalExpense = 0;
  String maxAmount = "10000";

  @override
  void initState() {
    super.initState();

    _pages = [
      ExpenseList(
        onSubmitted: updateIndex,
        onIconPressed: updateUi,
      ),
      AddExpenses(
        onIconPressed: updateUi,
        onNewAmountEntered: updateEnterData,
      ),
      Graph(onIconPressed: updateUi,),
      SettingClass(
        onIconPressed: updateUi,
        onUpadte: updateMaxAmount,
      ),

    ];
    calculateData();
  }


// Function to update the maximum amount
  void updateMaxAmount(String newMaxAmount) {
    setState(() {
      maxAmount = newMaxAmount;
    });
    calculateData();
  }
  void updateUi(){
    print("bottom nav bar ui updaste");
    setState(() {

    });
  }

  // Function to update the entered data
  void updateEnterData(String newValue) {
    double double1 = double.parse(newValue);
    setState(() {
      totalExpense = totalExpense + double1;
    });
    calculateData();
  }

  // Function to update the selected index
  void updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
    calculateData();
  }

  // Function to calculate and update data
  void calculateData() {
    double max = double.parse(maxAmount);
    double total = (totalExpense);
    setState(() {
      MyMethods.totalExpense = totalExpense;
      MyMethods.maxAmount = max;
      MyMethods.usePercentage = (total / max) * 100;
      MyMethods.percentage = total / max;
      MyMethods.reset = max - total;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
        decoration: BoxDecoration(
          color: MyMethods.MainColor.withOpacity(0.1),
          border: Border(),
        ),
        child: GNav(
          onTabChange: updateIndex,
          selectedIndex: _currentIndex,
          color: MyMethods.MainColor, // Replace with MyMethods.MainColor
          mainAxisAlignment: MainAxisAlignment.center,
          style: GnavStyle.google,
          gap: 9,
          padding: const EdgeInsets.all(25),
          tabBackgroundColor: MyMethods.MainColor, // Replace with MyMethods.MainColor
          tabBorder: Border.all(color: Colors.transparent),
          activeColor: Colors.white,
          tabs: [
            GButton(
              icon: Icons.list,
              text: "List",
            ),
            GButton(
              icon: Icons.add,
              text: "Add",
            ),
            GButton(
              icon: Icons.bar_chart,
              text: "Chart",
            ),
            GButton(
              icon: Icons.settings,
              text: "Setting",
            ),

          ],
        ),
      ),
      body: _pages[_currentIndex], // Show the selected page.
    );
  }
}
