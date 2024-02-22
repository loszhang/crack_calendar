import 'package:flutter/material.dart';

class HTaskShape extends StatelessWidget {
  final Color currentColor;
  final Function(Color) onColorChange;

  HTaskShape({Key? key, required this.currentColor, required this.onColorChange})
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
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: currentColor,
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
                    color: currentColor,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}