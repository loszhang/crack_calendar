import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color color; // 颜色参数

// 构造函数要求传入颜色
  ColorItem({required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 当点击按钮时关闭弹出框并返回颜色
        Navigator.pop(context, color);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color, // 使用构造函数传入的颜色
        ),
      ),
    );
  }
}
