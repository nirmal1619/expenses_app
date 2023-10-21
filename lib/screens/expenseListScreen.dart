import 'package:expenses_app/widgets/MyMethods.dart';
import 'package:expenses_app/widgets/tStructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../expense/expense.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key, required this.onSubmitted, required this.onIconPressed,});

  final Function(int) onSubmitted;
  final Function onIconPressed;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

final List<Expense> expense = []; //expense list

ScrollController _scrollController = ScrollController();

class _ExpenseListState extends State<ExpenseList> {
  void valuesOnDelete(int index) {
    setState(() {
      MyMethods.totalExpense = MyMethods.totalExpense - double.parse(expense[index].amount);
      MyMethods.expenseNumber = MyMethods.expenseNumber - 1;
      MyMethods.reset = MyMethods.reset + double.parse(expense[index].amount);
      MyMethods.usePercentage = (MyMethods.totalExpense / MyMethods.maxAmount) * 100;
    });
  }

  void valeOnAddAgain(Expense localExpense) {
    setState(() {
      MyMethods.totalExpense = MyMethods.totalExpense + double.parse(localExpense.amount);
      MyMethods.expenseNumber = MyMethods.expenseNumber + 1;
      MyMethods.reset = MyMethods.reset - double.parse(localExpense.amount);
      MyMethods.usePercentage = (MyMethods.totalExpense / MyMethods.maxAmount) * 100;
    });
  }
  void updateUi(){
   widget.onIconPressed();
    setState(() {

    });
  }
  // Function to delete an item from the list
  void deleteItem(int index) {
    Expense localExpense = expense[index];
    setState(() {
      valuesOnDelete(index);
      expense.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            valeOnAddAgain(localExpense);
            setState(() {
              expense.insert(index, localExpense);
            });
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:  MyMethods.MainColor, // Background color
          border: Border.all(
            color: Colors.white, // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Center(
          child: IconButton(
            onPressed: () {

              widget.onSubmitted(1);
            },
            iconSize: 40, // Adjust the icon size as needed
            icon: Icon(
              Icons.add, // Replace with your desired icon
              color: Colors.white, // Icon color
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          MyMethods.SAppBar(
            onIconPressed: updateUi,
            context: context
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 1, top: 1),
                  child: Container(
                    height: 60,
                    child: Slidable(
                      endActionPane: ActionPane(
                        key: ValueKey(index),
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              deleteItem(index);
                            },
                            borderRadius: BorderRadius.circular(12),
                            backgroundColor: MyMethods.MainColor,
                            icon: Icons.delete_outline_outlined,
                            label: "delete",
                          )
                        ],
                      ),
                      child: Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                          titleAlignment: ListTileTitleAlignment.center,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          iconColor: MyMethods.MainColor,
                          title: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TStructure(
                                    text: expense[index].id.toString(),
                                    tColor: MyMethods.MainColor,
                                    tSize: 15),
                                    Column(  
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                      
                                    TStructure(
                                        text: expense[index].tittle,
                                        tColor: MyMethods.MainColor,
                                        tSize: 20),
                                   SizedBox(height: 5), 
                                    getcategoryIcon(expense[index].catagory),
                                  ],
                                ),
                                    Column(
                                    
                                  children: [
                                    SizedBox(height: 0), // Add padding here
                                    TStructure(
                                        text: "Price",
                                        tColor: MyMethods.MainColor,
                                        tSize: 20),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TStructure(
                                        text: "Rs." + expense[index].amount,
                                        tColor: MyMethods.MainColor,
                                        tSize: 15
                                        ),
                                  ],
                                ),
                                
                                
                                Column(
                                  children: [
                                    SizedBox(height: 0), // Add padding here
                                    TStructure(
                                        text: "Date",
                                        tColor: MyMethods.MainColor,
                                        tSize: 20),
                                    Row(
                                      children: [
                                        TStructure(
                                          text: "${expense[index].date.day.toString()}",
                                          tColor: MyMethods.MainColor,
                                          tSize: 20,
                                        ),
                                        TStructure(
                                          text: "/${expense[index].date.month.toString()}",
                                          tColor: MyMethods.MainColor,
                                          tSize: 17,
                                        ),
                                        TStructure(
                                          text: "/${expense[index].date.year.toString()}",
                                          tColor: MyMethods.MainColor,
                                          tSize: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: expense.length,
            ),
          ),
        ],
      ),
    );
  }
}

Icon getcategoryIcon(Category category) {
  switch (category) {
    case Category.travel:
      return CategoryIcon().travelIcon;
    case Category.food:
      return CategoryIcon().foodIcon;
    case Category.movie:
      return CategoryIcon().MovieIcon;
    case Category.rent:
      return CategoryIcon().RentIcon;
    case Category.electronic:
      return CategoryIcon().EleIcon;
  }
}
