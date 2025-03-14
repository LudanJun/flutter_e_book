import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//活动标签
class MyBookActivityLabels extends StatefulWidget {
  final List<String> labels;
  final Function(int index)? itemTap;
  const MyBookActivityLabels({super.key, required this.labels, this.itemTap});

  @override
  State<MyBookActivityLabels> createState() => _MyBookActivityLabelsState();
}

class _MyBookActivityLabelsState extends State<MyBookActivityLabels> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '活动类型',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          5.verticalSpace,
          Wrap(
            children: List.generate(widget.labels.length, (index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: ChoiceChip(
                  label: Text(
                    widget.labels[index],
                  ),
                  selected: _value == index,
                  onSelected: (value) {
                    if (_value == index) return;
                    setState(() {
                      _value = index;
                    });
                    // 回调点击的选项
                    widget.itemTap?.call(index);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
