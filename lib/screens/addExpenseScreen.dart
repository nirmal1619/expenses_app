import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../expense/expense.dart';
import '../widgets/MyMethods.dart';
import '../widgets/tStructure.dart';
import 'expenseListScreen.dart';

class AddExpenses extends StatefulWidget {
  final Function(String) onNewAmountEntered;
  final Function onIconPressed;
  const AddExpenses({super.key, required this.onNewAmountEntered, required this.onIconPressed});

  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  var sharedPreferences;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final TextEditingController _tittleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  Category _selectedCatagary = Category.food;

  final dateFormat = DateFormat.yMEd();

  int number = 0;
  double totalAmountYet = 0;

  @override
  void initState() {
    super.initState();
    initalGetSaveData();
  }
  void updateUi(){
    widget.onIconPressed();
    setState(() {

    });
  }
  void initalGetSaveData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonDatais =
    jsonDecode(sharedPreferences.getString('userData'));
    Expense localExpense = Expense.fromJson(jsonDatais);

    if (jsonDatais.isNotEmpty) {
      setState(() {});
    }
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
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Form(
                      key: _formKey1,
                      child: TextFormField(
                        controller: _tittleController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: "Enter title",
                          labelText: "Title",
                          labelStyle: TextStyle(
                              color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title Can't Be Empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Form(
                            key: _formKey2,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Amount";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {},
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: "Enter amount",
                                labelText: "Amount",
                                labelStyle: TextStyle(
                                    color: MyMethods.MainColor), // Replace with MyMethods.MainColor
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                color: MyMethods.MainColor, // Replace with MyMethods.MainColor
                              ),
                              iconSize: 35,
                            ),
                            TStructure(
                              text: dateFormat
                                  .format(selectedDate ?? DateTime.now())
                                  .toString(),
                              tColor: Colors.black,
                              tSize: 15,
                            )
                          ],
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top: 20)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<Category>(
                          value: _selectedCatagary,
                          items: Category.values.map((category) {
                            return DropdownMenuItem<Category>(
                              value: category,
                              child: Text(category.toString().split('.').last,style: TextStyle(color: MyMethods.MainColor),),
                            );
                          }).toList(),
                          onChanged: (Category? newValue) {
                            setState(() {
                              _selectedCatagary = newValue!;
                            });
                          },
                        ),
                        TextButton(
                          child: TStructure(
                              text: "Submit",
                              tColor: Colors.white,
                              tSize: 15),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey1.currentState!.validate() &&
                                _formKey2.currentState!.validate()) {
                              _addExpensesToList(context);
                              widget.onNewAmountEntered(
                                  totalAmountYet.toString());
                              MyMethods.ShowSnackbar(
                                  context, "Expense added");

                              if (MyMethods.reset < 2001) {
                                MyMethods.ShowSnackbar(
                                    context,
                                    MyMethods.reset.toString() +
                                        "Money Left");
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: MyMethods
                                .MainColor, // Replace with MyMethods.MainColor
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _addExpensesToList(BuildContext context) async {
    DateTime? selectedDateTime = selectedDate;
    setState(() {
      MyMethods.expenseNumber = MyMethods.expenseNumber + 1;
    });

    if (selectedDateTime != null) {
      setState(() {
        expense.add(Expense(
          id: MyMethods.expenseNumber,
          tittle: _tittleController.text,
          amount: amountController.text,
          catagory: _selectedCatagary,
          date: selectedDateTime,
        ));
      });

      MyMethods.ByCatagaryExpense(
          _selectedCatagary, double.parse(amountController.text));

      Expense expenseData = Expense(
        id: number,
        tittle: _tittleController.text,
        amount: amountController.text,
        catagory: _selectedCatagary,
        date: selectedDateTime,
      );

      String userExpenseData = jsonEncode(expenseData);
      print(userExpenseData);

      sharedPreferences.setString('userData', userExpenseData);
    }

    double? doubleValue = double.tryParse(amountController.text);
    if (doubleValue != null) {
      setState(() {
        totalAmountYet = doubleValue;
      });
    }

    _tittleController.clear();
    amountController.clear();
  }
}
