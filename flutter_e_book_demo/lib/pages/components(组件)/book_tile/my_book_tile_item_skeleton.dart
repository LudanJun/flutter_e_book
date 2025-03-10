import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MyBookTileitemSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? showPrice;

  const MyBookTileitemSkeleton(
      {super.key, this.width, this.height, this.showPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.inverseSurface,
        highlightColor: Theme.of(context).colorScheme.onInverseSurface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: width, //120.w,
                  height: height, //160.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            //标题
            Container(
              padding: EdgeInsets.only(top: 10.h),
              height: 20.h, //必须给高度
              width: width, //120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            5.verticalSpace,
            //副标题
            Container(
              padding: EdgeInsets.only(top: 5.h),
              height: 18.h, //必须给高度
              width: width == null ? null : width! - 20.w, //120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
