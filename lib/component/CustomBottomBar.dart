import 'package:calendar/color_constant.dart';
import 'package:flutter/material.dart';

import '../new_plan.dart';

class CustomBottomBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  CustomBottomBar({required this.onItemSelected, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Container(
            height: 60,
            width: 240,
            decoration: BoxDecoration(
              color: ColorConstant.crackBlacks,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTabItem(
                    index: 0,
                    icon: Icon(Icons.home),
                    context: context,
                    title: 'Home'),
                buildTabItem(
                    index: 1,
                    icon: Icon(Icons.public_outlined),
                    context: context,
                    title: 'Task'),
                buildTabItem(
                    index: 2,
                    icon: Icon(Icons.person),
                    context: context,
                    title: 'Me'),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: ColorConstant.crackBlacks, shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                color: ColorConstant.crackGrayLight,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewPlan()));
            },
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
    required String title,
    required BuildContext context,
  }) {
    Color color = index == selectedIndex
        ? ColorConstant.crackGrayLight
        : ColorConstant.crackBlack;
    return Container(
      height: 45,
      width: index == selectedIndex ? 95 : 65,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            index == selectedIndex
                ? Text(
                    title,
                    style: TextStyle(
                        color: ColorConstant.crackBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                : Container(),
          ],
        ),
        onTap: () => onItemSelected(index),
      ),
    );
  }
}
