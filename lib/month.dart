import 'package:calendar/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextStyle weekStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey);
  TextStyle todayWeekStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle weekTodayDayStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle dayStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.grey);
  TextStyle todayDayStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle nealyTaskStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black);

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
      )),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          month(),
          SizedBox(
            height: 10,
          ),
          week
              ? weekView()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: monthTableView(),
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
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: week ? Colors.black : Colors.grey),
              ),
              onTap: () {
                setState(() {
                  week = true;
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            Text('/',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              child: Text(
                'M',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: week ? Colors.grey : Colors.black),
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

  List<TableRow> buildWeekDays() {
    bool isToday;
    return List.generate(2, (index) {
      return TableRow(
        children: dayLabels.map((label) {
          if (index == 0) {
            isToday = DateTime.now().weekday == dayLabels.indexOf(label) + 1;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: isToday ? todayWeekStyle : weekStyle),
            );
          } else {
            isToday = DateTime.now().weekday == dayLabels.indexOf(label) + 1;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '${getWeekDates()[dayLabels.indexOf(label)].split('-')[2]}',
                  textAlign: TextAlign.center,
                  style: isToday ? weekTodayDayStyle : dayStyle),
            );
          }
        }).toList(),
      );
    });
  }

  Widget weekTableView() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
      },
      children: [
        ...buildWeekDays(),
        const TableRow(children: [
          Divider(thickness: 1, indent: 5, endIndent: 5),
          Divider(thickness: 1, indent: 5, endIndent: 5),
          Divider(thickness: 1, indent: 5, endIndent: 5),
          Divider(thickness: 1, indent: 5, endIndent: 5),
          Divider(thickness: 1, indent: 5, endIndent: 5),
          Divider(thickness: 1, indent: 5, endIndent: 5),
          Divider(thickness: 1, indent: 5, endIndent: 5),
        ]),
        // Add your NearlyTask widgets here as TableRow
        // Each NearlyTask should be wrapped with a TableCell and a Padding if needed
        const TableRow(
          children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: SizedBox(height: 10)),
            // Replace with your NearlyTask Widget
            TableCell(child: SizedBox()),
            // Empty cells for gaps
            TableCell(child: SizedBox()),
            TableCell(child: SizedBox()),
            TableCell(child: SizedBox()),
            TableCell(child: SizedBox()),
            TableCell(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget weekView() {
    return Column(
      children: [
        weekTableView(),
        SizedBox(
          height: 10,
        ),
        NearlyTask(
          title: 'Cleaning Room',
          time: '08:00 - 10:00 /Personal',
          initiallyChecked: false,
        ),
        SizedBox(
          height: 10,
        ),
        NearlyTask(
          title: 'Cooking',
          time: '12:00 - 13:00 /Personal',
          initiallyChecked: false,
        ),
      ],
    );
  }

  Widget monthTableView() {
    // 计算需要的网格行数
    int totalSlots = daysInMonth + startWeekday - 1;
    int numRows = (totalSlots / 7).ceil();

    // 构建表格行
    List<TableRow> buildMonthDays() {
      List<TableRow> rows = [];
      for (int i = 0; i < numRows; i++) {
        List<Widget> dayWidgets = [];
        for (int j = 0; j < 7; j++) {
          int index = i * 7 + j;
          if (index < startWeekday - 1 ||
              index >= daysInMonth + startWeekday - 1) {
            // 如果是前空位或者后空位
            dayWidgets.add(Container()); // 显示空白格子
          } else {
            // 格子内的日期
            int dayNumber = index - startWeekday + 2;
            bool isToday = dayNumber == today;
            dayWidgets.add(Container(
              color: isToday ? ColorConstant.crackBlack : null,
              width: MediaQuery.of(context).size.width / 7,
              child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Text(
                      '$dayNumber',
                      style: isToday ? todayDayStyle : dayStyle,
                    ),
                    // 示例待办事项，根据实际需求显示
                    dayNumber % 6 == 0 ? Column(
                      children: [
                        Container(
                          height: 10,
                          color: Colors.lightBlue,
                        ),
                        Container(
                          height: 10,
                          color: Colors.orange,
                        )
                      ],
                    ) : Container(),
                  ],
                ),
              ),
            ));
          }
        }
        rows.add(TableRow(children: dayWidgets));
      }
      return rows;
    }

    // 构建星期标签的行
    TableRow buildWeekDays() {
      return TableRow(
        children: dayLabels.map((label) {
          bool isToday = DateTime.now().weekday == dayLabels.indexOf(label) + 1;
          return Container(
            width: MediaQuery.of(context).size.width / 7, // 指定宽度，使得与日期宽度一致
            height: 20, // 指定高度，使得与日期高度一致
            alignment: Alignment.center,
            child: Text(
              label,
              style: isToday ? todayWeekStyle : weekStyle,
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the weekday texts
        Table(
          columnWidths:
              { for (var index in List.generate(7, (index) => index)) index : FixedColumnWidth(MediaQuery.of(context).size.width / 7) },
          // 设定宽度，你可以设置为你想要的尺寸
          children: [
            buildWeekDays(),
            const TableRow(
              children: [
                Divider(),
                Divider(),
                Divider(),
                Divider(),
                Divider(),
                Divider(),
                Divider(),
              ]
            ),

            ...buildMonthDays(),
          ],
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
            bool isToday =
                DateTime.now().weekday == dayLabels.indexOf(label) + 1;
            return Text(label, style: isToday ? todayWeekStyle : weekStyle);
          }).toList(),
        ),
        const Divider(),
        // 使用GridView.builder生成每个月的日视图
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      weekDates.add(
          "${dayOfWeek.year}-${dayOfWeek.month.toString().padLeft(2, '0')}-${dayOfWeek.day.toString().padLeft(2, '0')}");
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
