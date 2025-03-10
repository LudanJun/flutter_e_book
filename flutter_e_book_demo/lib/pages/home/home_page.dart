import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/model/activity.dart';
import 'package:flutter_e_book_demo/model/book.dart';
import 'package:flutter_e_book_demo/pages/components(%E7%BB%84%E4%BB%B6)/book_tile/my_book_tile.dart';
import 'package:flutter_e_book_demo/pages/components(%E7%BB%84%E4%BB%B6)/my_search_tile.dart';
import 'package:flutter_e_book_demo/pages/home/components(home%20%E7%BB%84%E4%BB%B6)/my_book_activities.dart';
import 'package:flutter_e_book_demo/pages/home/components(home%20%E7%BB%84%E4%BB%B6)/my_book_activities_skeleton.dart';
import 'package:flutter_e_book_demo/pages/home/components(home%20%E7%BB%84%E4%BB%B6)/my_book_activity_labels.dart';
import 'package:flutter_e_book_demo/pages/home/components(home%20%E7%BB%84%E4%BB%B6)/my_book_activity_labels_skeleton.dart';
import 'package:flutter_e_book_demo/pages/home/hme_vm.dart';
import 'package:flutter_e_book_demo/utils/log_extern.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> activities = [
  //   "全部",
  //   "读书专题",
  //   "直播活动",
  //   "名家问答",
  //   "共读交流",
  //   "鉴书团",
  // ];

  /// 轮播图数组
  // List<String> images = [
  //   'https://img3.doubanio.com/mpic/book-activity-fa7d714bf3804056b5234ee71a9a9d13',
  //   'https://img3.doubanio.com/mpic/book-activity-5f72c3983c7545c1910cfd569c2c4a82',
  //   'https://img3.doubanio.com/mpic/book-activity-fa7d714bf3804056b5234ee71a9a9d13',
  //   'https://img3.doubanio.com/mpic/book-activity-5f72c3983c7545c1910cfd569c2c4a82',
  // ];

  ///书籍信息
  List<Map<String, dynamic>> books = [
    {
      "title": "食南之徒",
      "authorName": "作者: 马伯庸",
      "cover": "https://img3.doubanio.com/view/subject/s/public/s34823157.jpg",
    },
    {
      "title": "赎罪",
      "authorName": "[日] 凑佳苗",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34853929.jpg",
    },
    {
      "title": "八月我们相见",
      "authorName": "哥伦比亚 加西亚·马尔克斯",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34797230.jpg",
    },
    {
      "title": "八月我们相见",
      "authorName": "哥伦比亚 加西亚·马尔克斯",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34797230.jpg",
    },
    {
      "title": "八月我们相见",
      "authorName": "哥伦比亚 加西亚·马尔克斯",
      "cover": "https://img1.doubanio.com/view/subject/s/public/s34797230.jpg",
    },
  ];
  //创建 viewmodel 对象 状态管理 来调用爬虫方法
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getBodyUI(),
    );
  }

  Widget _getBodyUI() {
    //因为我们已经创建了_viewModel状态管理 所以使用.value创建
    return ChangeNotifierProvider.value(
      value: _viewModel,
      builder: (context, child) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                //扩展写法,纵间距 第三方库的扩展 const SizedBox(height: 10.h,),
                10.verticalSpace,

                //1.头像
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '您好，豆瓣',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        backgroundImage: const AssetImage('images/avatar.jpg'),
                      ),
                    ),
                  ],
                ),
                15.verticalSpace,
                //2.搜索
                MySearchTile(
                  bookshelfTap: () {
                    print("点击搜索");
                  },
                ),
                30.verticalSpace,

                //3.读书活动
                // MyBookActivities(activites:activities ?? ,);
                //使用 provider提供的 Selector 组件去包括我们的读书活动
                //使用Selector 需要包裹在 ChangeNotifieProvider下面
                //Selector会监听某一个对象的变化,当这个对象的地址发生变化的时候它会刷新我们的 ui 组件
                //跟 Consumer 的区别在于Selector 的刷新范围更下小. Consumer会监听 provider 中所有对象的变化
                //一但我们调用通知方法它会刷新其包裹的组件,也就是说如果一个对象跟我们包裹组件没有关系,你调用了 notifyListeners 方法一样会刷新

                Selector<HomeViewModel, List<Activity>?>(
                  builder: (context, List<Activity>? activities, child) {
                    if (activities == null) {
                      //这里可以展示骨架图
                      return const MyBookActivitiesSkeleton();
                    }
                    return MyBookActivities(activities: activities);
                  },
                  selector: (_, viewModel) => viewModel.activities,
                ),

                15.verticalSpace,

                //活动类型
                Selector<HomeViewModel, List<String>?>(
                  builder: (context, labels, child) {
                    if (labels == null) {
                      //这里可以展示骨架图
                      return const MyBookActivitiesLabelsSkeleton();
                    }
                    return MyBookActivityLabels(
                      labels: labels,
                      itemTap: (index) {
                        AALog(index);
                        int? kind = index == 0 ? null : index - 1;
                        _viewModel.getBookActivities(kind);
                      },
                    );
                  },
                  selector: (_, viewModel) => viewModel.activityLabels,
                ),

                30.verticalSpace,

                //特别为您准备
                Selector<HomeViewModel, List<Book>?>(
                  builder: (context, books, child) {

                    return MyBookTile(
                      books: books,
                      width: 120.w,
                      height: 160.h,
                    );
                  },
                  selector: (_, viewModel) => viewModel.books,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
