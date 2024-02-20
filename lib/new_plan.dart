import 'package:calendar/color_constant.dart';
import 'package:calendar/component/color_item.dart';
import 'package:flutter/material.dart';

class NewPlan extends StatefulWidget {
  @override
  State createState() {
    return _NewPlanState();
  }
}

class _NewPlanState extends State<NewPlan> {
  Color _selectedColor = ColorConstant.crackPurple;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'New plan',
              style: TextStyle(color: ColorConstant.crackGrayMedium, fontSize: 30),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 15,),
              title(),
              Divider(),
              date(),
              Divider(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                  ),
                  child: Icon(Icons.add),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget title() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle:
                  TextStyle(color: ColorConstant.crackGrayMedium, fontSize: 30),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Today', style: TextStyle(color: ColorConstant.crackGrayMedium, fontSize: 34),),
            Text('5:00 PM', style: TextStyle(color: ColorConstant.crackGrayMedium, fontSize: 34),)
          ],
        )
      ],
    );
  }
}
