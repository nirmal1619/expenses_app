
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

enum Category{food,travel,movie,rent,electronic}
@HiveType(typeId :0 )
class Expense{

final int id;
final String tittle;
final String amount;
final Category catagory;
final DateTime date;


  Expense({required this.id, required this.tittle, required this.amount,
   required this.catagory, required this.date});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tittle': tittle,
      'amount': amount,
      'catagory': describeEnum(catagory), // Convert enum to string
      'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      tittle: json['tittle'],
      amount: json['amount'],
      catagory: _getCategoryFromString(json['catagory']),
      date: DateTime.parse(json['date']),
    );
  }

  // Helper function to convert a string to the Catagary enum
  static Category _getCategoryFromString(String categoryString) {
    return Category.values.firstWhere(
      (e) => describeEnum(e) == categoryString,
      orElse: () => Category.food, // Default value if not found
    );
  }
}
  //  Map<String,dynamic> toJson=>{
  //   'id':id,
  //   'tittle':tittle,
  //   'amount':amount,
  //   'catagory': Category,
  //   'date':date
  //  };


class CategoryIcon{
  final travelIcon = Icon(CupertinoIcons.map_pin_ellipse, size: 20);
  final foodIcon = Icon(Icons.restaurant, size: 20);
  final MovieIcon = Icon(CupertinoIcons.tv, size: 20);
  final RentIcon = Icon(CupertinoIcons.home, size: 20);
  final EleIcon =  Icon(Icons.power_outlined, size: 20);


}