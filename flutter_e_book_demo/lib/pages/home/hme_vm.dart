// 给 homepage 创建 viewmodel 对象
import 'package:flutter_e_book_demo/http/spider/spider_api.dart';
import 'package:flutter_e_book_demo/model/activity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_e_book_demo/model/book.dart';

//viewmodel 要继承自ChangeNotifier
class HomeViewModel extends ChangeNotifier {
  // 读书活动数组
  List<Activity>? _activities;
  // 定义一下它的 get
  List<Activity>? get activities => _activities;
  // set 方法
  set activities(List<Activity>? activities) {
    _activities = activities;
    // 使用 set 方法赋值的时候会通知 ui 更新
    notifyListeners();
  }

  // 活动标签
  List<String>? _activityLabels;
  // 定义一下它的 get
  List<String>? get activityLabels => _activityLabels;
  // set 方法
  set activityLabels(List<String>? activityLabels) {
    _activityLabels = activityLabels;
    // 使用 set 方法赋值的时候会通知 ui 更新
    notifyListeners();
  }

  //书籍数组
  List<Book>? _books;
  List<Book>? get books => _books;
  set books(List<Book>? books) {
    _books = books;
    // 使用 set 方法赋值的时候会通知 ui 更新
    notifyListeners();
  }

  //获取首页所有数据
  Future getHomePageData() async {
    await SpiderApi.instance().fetchHomeData(
      // activitiesCallback: (values) {
      //   activities = values;
      // },
      // activityLabelsCallback: (values) {
      //   activityLabels = values;
      // },
      activitiesCallback: (values) => activities = values,
      activityLabelsCallback: (values) => activityLabels = values,
      booksCallback: (values) => books = values,
    );
  }

  Future getBookActivities(int? kind) async {
    activities = await SpiderApi.instance().fetchBookActivities(kind);
  }

  /*
  /// 该方法会在 initState 放里面调用,就是在页面还没加载之前调用
  Future getActivities() async {
    // 获取读书活动的数据
    activities = await SpiderApi.instance().fetchHomeData();

    // AALog(activities);
  }
  */
}
