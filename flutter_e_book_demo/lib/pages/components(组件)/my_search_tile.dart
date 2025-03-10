import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

/// 搜索控件
class MySearchTile extends StatelessWidget {
  //搜索回调
  final VoidCallback? bookshelfTap;
  const MySearchTile({super.key, this.bookshelfTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          //Container宽度用Expanded撑开
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.w),
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '搜索...',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10.w),
          child: IconButton(
            onPressed: bookshelfTap,
            icon: Icon(
              LineIcons.stream,
              size: 25.r,
            ),
          ),
        ),
      ],
    );
  }
}
