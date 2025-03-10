import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/model/book.dart';
import 'package:flutter_e_book_demo/pages/components(%E7%BB%84%E4%BB%B6)/book_tile/my_book_tile_item.dart';
import 'package:flutter_e_book_demo/pages/components(%E7%BB%84%E4%BB%B6)/book_tile/my_book_tile_item_skeleton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookTile extends StatelessWidget {
  final List<Book>? books;
  final double? width;
  final double? height;
  final bool? showPrice;
  const MyBookTile({
    super.key,
    required this.books,
    this.width,
    this.height,
    this.showPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '特别为您准备',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        15.verticalSpace,
        // 书籍信息
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(books?.length ?? 5, (index) {
              if (books == null) {
                //骨架图
                return MyBookTileitemSkeleton(
                  width: width,
                  height: height,
                );
              }
              return MyBookTileItem(
                book: books![index],
                width: width,
                height: height,
                showPrice: showPrice,
              );
            }),
          ),
        ),
      ],
    );
  }
}
