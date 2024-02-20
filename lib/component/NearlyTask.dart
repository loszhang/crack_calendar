import 'package:flutter/material.dart';

class NearlyTask extends StatefulWidget {
  final String title;
  final String time;
  final bool initiallyChecked;

  NearlyTask({
    Key? key,
    required this.title,
    required this.time,
    this.initiallyChecked = false,
  }) : super(key: key);

  @override
  _NearlyTaskState createState() => _NearlyTaskState();
}

class _NearlyTaskState extends State<NearlyTask> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.initiallyChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 180,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
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
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      widget.time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
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
              ),
            ],
          ),
          // 其他子元素...
        ],
      ),
    );
  }
}