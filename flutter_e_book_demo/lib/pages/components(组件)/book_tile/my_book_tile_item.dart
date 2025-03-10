import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/model/book.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookTileItem extends StatelessWidget {
  final Book book;
  final double? width;
  final double? height;
  final bool? showPrice;

  const MyBookTileItem(
      {super.key, required this.book, this.width, this.height, this.showPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: width, //120.w,
                height: height, //160.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      book.cover ?? "",
                      headers: const {
                        'User-Agent':
                            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0'
                      },
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //价格 灵活显示
              _getPriceUI(context),
            ],
          ),

          //标题
          Container(
            padding: EdgeInsets.only(
              top: 10.h,
            ),
            width: width, //120.w,
            child: Text(
              book.title ?? "",
              maxLines: 1,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //副标题
          Container(
            padding: EdgeInsets.only(
              top: 10.h,
            ),
            width: width, //120.w,
            child: Text(
              book.authorName ?? "",
              maxLines: 1,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPriceUI(BuildContext context) {
    if (showPrice == false) {
      return const SizedBox();
    }
    return Positioned(
      bottom: height == null ? 20 : height! / 3, //160 / 3,
      child: Container(
        width: 65.w,
        height: 25.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          ),
        ),
        child: Center(
          child: Text(
            '¥12.0',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
