import 'dart:ui';

import 'package:calendar/color_constant.dart';
import 'package:calendar/component/color_item.dart';
import 'package:calendar/component/f_task_shape.dart';
import 'package:calendar/component/h_task_shape.dart';
import 'package:calendar/component/l_task_shape.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'component/i_task_shape.dart';

class NewPlan extends StatefulWidget {
  @override
  State createState() {
    return _NewPlanState();
  }
}

class _NewPlanState extends State<NewPlan> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  Color _selectedColor = ColorConstant.crackPurple;
  TextStyle textFieldStyle =
      TextStyle(color: ColorConstant.crackGrayLight, fontSize: 30);
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

  SizedBox sizedBox4 = const SizedBox(
    width: 4,
  );
  SizedBox sizedBox15 = const SizedBox(
    height: 15,
  );

  // 这个方法用于改变颜色，它可以作为回调传递给 CustomLWidget
  void _changeColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.crackBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorConstant.crackBlack,
      ),
      body: GestureDetector(
        onTap: () {
          // 当点击空白处时，移除焦点，从而关闭键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'New plan',
                        style: textStyle,
                      ),
                    ),
                    Column(
                      children: [
                        sizedBox15,
                        title(),
                        const Divider(),
                        sizedBox15,
                        date(),
                        const Divider(),
                        sizedBox15,
                        shapeSize(),
                        const Divider(),
                        sizedBox15,
                        taskKind(),
                        const Divider(),
                      ],
                    )
                  ],
                ),
                Positioned(
                  bottom: 80,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextField(
              style: textFieldStyle,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                    color: ColorConstant.crackGrayMedium, fontSize: 30),
                border: InputBorder.none,
                // 去掉下划线
                contentPadding: const EdgeInsets.only(left: 30),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showColorPickerDialog(context).then((selectedColor) {
                      if (selectedColor != null) {
                        // 处理选中的颜色，例如将其用于设置某些状态或UI。
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  padding: const EdgeInsets.only(left: 30),
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
              padding: const EdgeInsets.only(right: 12),
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
      padding: const EdgeInsets.only(left: 30),
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
            sizedBox4,
            Text(
              '/',
              style: selectTextStyle,
            ),
            sizedBox4,
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
      padding: const EdgeInsets.only(left: 30),
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
                    'I',
                    style: kindStr == 'I' ? textStyle : selectTextStyle,
                  ),
                  onTap: () {
                    setState(() {
                      kindStr = 'I';
                    });
                  },
                ),
                sizedBox4,
                Text(
                  '/',
                  style: selectTextStyle,
                ),
                sizedBox4,
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
                sizedBox4,
                Text(
                  '/',
                  style: selectTextStyle,
                ),
                sizedBox4,
                GestureDetector(
                  child: Text(
                    'F',
                    style: kindStr == 'F' ? textStyle : selectTextStyle,
                  ),
                  onTap: () {
                    setState(() {
                      kindStr = 'F';
                    });
                  },
                ),
                sizedBox4,
                Text(
                  '/',
                  style: selectTextStyle,
                ),
                sizedBox4,
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
            kindStr == 'I'
                ? ITaskShape(
                    currentColor: _selectedColor, onColorChange: _changeColor)
                : (kindStr == 'L'
                    ? LTaskShape(
                        currentColor: _selectedColor,
                        onColorChange: _changeColor)
                    : kindStr == 'F' ? FTaskShape(currentColor: _selectedColor, onColorChange: _changeColor) : HTaskShape(
                currentColor: _selectedColor,
                onColorChange: _changeColor)),
          ],
        ),
      ),
    );
  }
}
