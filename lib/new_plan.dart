import 'dart:ui';

import 'package:calendar/color_constant.dart';
import 'package:calendar/component/color_item.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewPlan extends StatefulWidget {
  @override
  State createState() {
    return _NewPlanState();
  }
}

class _NewPlanState extends State<NewPlan> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  Color _selectedColor = ColorConstant.crackPurple;

  TextStyle textStyle =
      TextStyle(color: ColorConstant.crackGrayLight, fontSize: 34);
  TextStyle selectTextStyle =
      TextStyle(color: ColorConstant.crackGrayDark, fontSize: 34);

  late DateTime selectDay = DateTime.now();
  var kindStr = 'L';
  var taskKindStr = 'Personal';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.crackBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorConstant.crackBlack,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'New plan',
                  style: textStyle,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  title(),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  date(),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  shapeSize(),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  taskKind(),
                  Divider(),
                ],
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(bottom: 35),
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: _selectedColor,
                ),
                child: Icon(Icons.add, size: 35,),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget title() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                    color: ColorConstant.crackGrayMedium, fontSize: 30),
                border: InputBorder.none,
                // 去掉下划线
                contentPadding: EdgeInsets.only(left: 30),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showColorPickerDialog(context).then((selectedColor) {
                      if (selectedColor != null) {
                        // 处理选中的颜色，例如将其用于设置某些状态或UI。
                        print("选中的颜色: $selectedColor");
                        setState(() {
                          _selectedColor = selectedColor;
                        });
                      }
                    });
                  },
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                // 可以添加其他装饰属性，如hintText
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Color?> _showColorPickerDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          spacing: 10,
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            ColorItem(color: ColorConstant.crackPurple),
            ColorItem(color: ColorConstant.crackGrayDark),
            ColorItem(color: ColorConstant.crackGrayLight),
            ColorItem(color: ColorConstant.crackGrayMedium),
          ],
        );
      },
    );
  }

  Widget date() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Column(
              children: [
                Text(
                  dateFormat.format(selectDay) ==
                      dateFormat.format(DateTime.now())
                      ? 'Today'
                      : '${selectDay.year}/${selectDay.month}',
                  style: textStyle,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '${DateFormat('EEE').format(selectDay)}, ${DateFormat('d').format(selectDay)}',
                    style: selectTextStyle,
                  ),
                ),
              ],
            ),
            onTap: () {
              showCalendarDialog(context);
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Text(
                    '5:00 PM',
                    style: textStyle,
                  ),
                  Text(
                    '7:00 PM',
                    style: selectTextStyle,
                  )
                ],
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Future<String?> showCalendarDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.white,
            child: DatePicker(
              minDate: DateTime(2021, 1, 1),
              maxDate: DateTime(2024, 12, 31),
              onDateSelected: (value) {
                Navigator.pop(context);
                print(selectDay);
                // Handle selected date
                setState(() {
                  selectDay = value;
                });
              },
            ),
          );
        });
  }

  Widget taskKind() {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              child: Text(
                'Personal',
                style: taskKindStr == 'Personal' ? textStyle : selectTextStyle,
              ),
              onTap: () {
                setState(() {
                  taskKindStr = 'Personal';
                });
              },
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '/',
              style: selectTextStyle,
            ),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              child: Text(
                'Team',
                style: taskKindStr == 'Team' ? textStyle : selectTextStyle,
              ),
              onTap: () {
                setState(() {
                  taskKindStr = 'Team';
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget shapeSize() {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Text(
                    'L',
                    style: kindStr == 'L' ? textStyle : selectTextStyle,
                  ),
                  onTap: () {
                    setState(() {
                      kindStr = 'L';
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '/',
                  style: selectTextStyle,
                ),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  child: Text(
                    'M',
                    style: kindStr == 'M' ? textStyle : selectTextStyle,
                  ),
                  onTap: () {
                    setState(() {
                      kindStr = 'M';
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '/',
                  style: selectTextStyle,
                ),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  child: Text(
                    'H',
                    style: kindStr == 'H' ? textStyle : selectTextStyle,
                  ),
                  onTap: () {
                    setState(() {
                      kindStr = 'H';
                    });
                  },
                )
              ],
            ),
            kindStr == 'L' ? L() : (kindStr == 'M' ? M() : H())
          ],
        ),
      ),
    );
  }

  Widget L() {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  Widget M() {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
          )
        ],
      ),
    );
  }

  Widget H() {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
