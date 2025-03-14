import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/model/activity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

/// 读书活动组件
class MyBookActivities extends StatelessWidget {
  // 传入读书活动数组
  final List<Activity> activities;
  const MyBookActivities({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '读书活动',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        10.verticalSpace,
        SizedBox(
          height: 150.h,
          width: double.infinity,
          child: Swiper(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  //背景图
                  Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          activities[index].cover ?? "",
                          headers: const {
                            'User-Agent':
                                'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0'
                          },
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //背景
                  Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  //文字
                  Container(
                    height: 150.h,
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //标题
                        Text(
                          activities[index].title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //专题标签
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                activities[index].label ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            10.horizontalSpace,
                            //时间
                            Text(
                              activities[index].time ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            //小圆点分页器
            pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white.withOpacity(0.4),
                activeColor: Colors.white,
                size: 8.0,
                activeSize: 10.0,
                space: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
