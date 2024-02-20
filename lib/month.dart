import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'component/NearlyTask.dart';

class Month extends StatefulWidget {
  @override
  State createState() {
    return _MonthState();
  }
}

class _MonthState extends State<Month> {

  bool week = true;

  bool checked = false;

  double weekFontSize = 15;
  TextStyle weekStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey);
  TextStyle todayWeekStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle weekTodayDayStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle dayStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.grey);
  TextStyle todayDayStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle nealyTaskStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black);

  DateTime now = DateTime.now();
  int today = DateTime.now().day;
  int thisMonth = DateTime.now().month;
  int daysInMonth = 30; // 假设当前月份有29天
  int startWeekday = DateTime.now().weekday; // 当月第一天是周几
  List<String> dayLabels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];


  @override
  void initState() {
    super.initState();
    daysInMonth = getDaysInMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 10, left: 3),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 50,
            ),
          ),
        )
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          month(),
          SizedBox(height: 10,),
          week ? weekView() : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: monthView(),

          ),
        ],
      ),
    );
  }

  Widget month() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          DateFormat('MMMM').format(now),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        SizedBox(
          width: 5,
        ),
        Row(
          children: [
            GestureDetector(
              child: Text(
                'W',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: week ? Colors.black : Colors.grey),
              ),
              onTap: () {
                setState(() {
                  week = true;
                });
              },
            ),
            SizedBox(width: 5,),
            Text('/', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.grey)),
            SizedBox(width: 5,),
            GestureDetector(
              child: Text(
                'M',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: week ? Colors.grey : Colors.black),
              ),
              onTap: () {
                setState(() {
                  week = false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget weekView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayLabels.map((label) {
            bool isToday = DateTime.now().weekday == dayLabels.indexOf(label) + 1;
            return Text(label, style: isToday ? todayWeekStyle : weekStyle);
          }).toList(),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getWeekDates().map((date) {
            bool isToday = DateTime.now().weekday == getWeekDates().indexOf(date) + 1;
            return Text(date.split('-')[2], style: isToday ? weekTodayDayStyle : dayStyle);
          }).toList(),
        ),
        SizedBox(height: 10,),
        NearlyTask(
          title: 'Cleaning Room',
          time: '08:00 - 10:00 /Personal',
          initiallyChecked: false,
        ),
        SizedBox(height: 10,),
        NearlyTask(
          title: 'Cooking',
          time: '12:00 - 13:00 /Personal',
          initiallyChecked: false,
        ),
      ],
    );
  }

  Widget monthView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 显示星期文本
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayLabels.map((label) {
            bool isToday = DateTime.now().weekday == dayLabels.indexOf(label) + 1;
            return Text(label, style: isToday ? todayWeekStyle : weekStyle);
          }).toList(),
        ),
        const Divider(),
        // 使用GridView.builder生成每个月的日视图
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 一周七天，所以crossAxisCount设置为7
              childAspectRatio: 1 / 2, // 子项目的高宽比
              crossAxisSpacing: 0,
            ),
            itemCount: startWeekday - 1 + daysInMonth,
            itemBuilder: (context, index) {
              // 生成每一天的容器
              if (index < startWeekday - 1) {
                // 如果是前空位子
                return Container(); // 显示空白格子
              } else {
                int dayNumber = index - startWeekday + 2;
                bool isToday = now.month == thisMonth && dayNumber == today;
                return Container(
                  color: isToday ? Colors.black : null,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        '$dayNumber',
                        style: isToday ? todayDayStyle : dayStyle,
                      ),
                      // 显示待办事项文本，这里是一个简单的示例
                      // 实际应用中可能需要根据该日期有无待办事项来决定是否显示此处的文本
                      Container(
                        height: 10,
                        color: Colors.lightBlue,
                      ),
                      Container(
                        height: 10,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  List<String> getWeekDates() {
    DateTime now = DateTime.now();
    int currentDayOfWeek = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1));

    List<String> weekDates = [];

    for (int i = 0; i < 7; i++) {
      DateTime dayOfWeek = startOfWeek.add(Duration(days: i));
      weekDates.add("${dayOfWeek.year}-${dayOfWeek.month.toString().padLeft(2, '0')}-${dayOfWeek.day.toString().padLeft(2, '0')}");
    }

    return weekDates;
  }

  int getDaysInMonth() {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;

    // 当月最后一天
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    return lastDayOfMonth.day;
  }

}