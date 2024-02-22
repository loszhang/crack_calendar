import 'package:flutter/material.dart';

class MTaskShape extends StatelessWidget {
  final Color currentColor;
  final Function(Color) onColorChange;

  MTaskShape({Key? key, required this.currentColor, required this.onColorChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 调用父组件传递过来的方法以改变颜色
        onColorChange(Colors.red);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}