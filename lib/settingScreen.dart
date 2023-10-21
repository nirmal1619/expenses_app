
import 'package:expenses_app/widgets/MyMethods.dart';
import 'package:flutter/material.dart';

class SettingClass extends StatefulWidget {
  final Function(String) onUpadte;
  final Function onIconPressed;
  SettingClass({super.key, required this.onUpadte, required this.onIconPressed});

  @override
  _SettingClassState createState() => _SettingClassState();
}

class _SettingClassState extends State<SettingClass> {
  final TextEditingController _controller = TextEditingController();
  String maxAmount = "5000";
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
          // Replace this with your custom SliverAppBar
          MyMethods.SAppBar(
              onIconPressed: updateUi,
              context: context,
          ),
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Max Limit',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyMethods.MainColor), // Use MyMethods.MainColor
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.attach_money,color: MyMethods.MainColor,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 26),
                        labelStyle: TextStyle(
                          color: MyMethods.MainColor, // Use MyMethods.MainColor
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyMethods.MainColor, // Use MyMethods.MainColor
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyMethods.MainColor, // Use MyMethods.MainColor
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),

                  ElevatedButton(

                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          maxAmount = _controller.text;
                          widget.onUpadte(maxAmount);
                        });
                        _controller.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: MyMethods.MainColor, // Use MyMethods.MainColor
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10), // Increase button height
                    ),
                    child: Text('Update',style: TextStyle(color: Colors.white),),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
