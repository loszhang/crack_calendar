import 'package:calendar/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'month.dart';
import 'new_plan.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: title(),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Month()));
              },
              icon: Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 50,
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              nearly(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewPlan()));
          },
          child: Icon(Icons.add, color: Colors.white, size: 35,),
          shape: CircleBorder(),
          backgroundColor: Colors.black,
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  Widget title() {
    return Row(
      children: [
        Text(
          '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('M').format(DateTime.now())}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              DateFormat('M/d').format(DateTime.now()),
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 5,
            )
          ],
        )
      ],
    );
  }

  Widget nearly() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 180,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstant.crackBlack,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 98,
                    child: Text(
                      'Cleaning Room',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      '12:00 - 14:00 /Team',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        checked = !checked;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        checked ? Icons.check : null,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
