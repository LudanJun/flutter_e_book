import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_e_book_demo/http/dio_instance.dart';
import 'package:flutter_e_book_demo/http/spider/api_string.dart';
import 'package:flutter_e_book_demo/model/activity.dart';
import 'package:flutter_e_book_demo/model/book.dart';
import 'package:flutter_e_book_demo/utils/log_extern.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

// 爬虫相关的 api
class SpiderApi {
  static SpiderApi? _instance;
  SpiderApi._();

  static SpiderApi instance() {
    return _instance ??= SpiderApi._();
  }

  /// 获取图书活动
  /// 根据参数 kind 来获取对应的图书活动
  /// [kind] 读书活动类型
  Future<List<Activity>> fetchBookActivities(int? kind) async {
    //全部无需参数
    Map<String, dynamic>? param = kind == null ? null : {"kind": kind};
    Response res = await DioInstance.instance().get(
      path: ApiString.bookActivitiesJsonUrl,
      param: param,
    );
    String htmlStr = res.data['result'];
    // AALog(htmlStr);
    Document doc = parse(htmlStr);
    return parseBookActivities(doc);
  }

  /// 获取首页数据
  Future fetchHomeData({
    //传入 callback 方法就会去解析对应的数据  然后把数据回调出去
    //1.活动轮播图
    Function(List<Activity> values)? activitiesCallback,
    //2.活动标签
    Function(List<String> values)? activityLabelsCallback,
    //3.书籍数组
    Function(List<Book> values)? booksCallback,
  }) async {
    // 返回是字符串类型的一个完整的 DOM 树
    // 通过它解析到里面的 HTML 节点属性
    String htmlStr = await DioInstance.instance()
        .getString(path: ApiString.bookDoubanHomeUrl);

    //这个方法返回Document对象就跟 js 里面的Document对象类似的
    Document doc = parse(htmlStr);

    // 解析活动数据
    if (activitiesCallback != null) {
      activitiesCallback.call(parseBookActivities(doc));
    }

    // 解析所有活动标签数据
    if (activityLabelsCallback != null) {
      List<Element> spanEls =
          doc.querySelectorAll(".books-activities .hd .tags .item");
      List<String> labels = [];
      for (Element span in spanEls) {
        labels.add(span.text.trim());
        AALog(span.text.trim());
      }
      activityLabelsCallback.call(labels);
    }

    // 解析书籍数据
    if (booksCallback != null) {
      booksCallback.call(parseHomeBooks(doc));
    }
  }

  List<Activity> parseBookActivities(Document doc) {
    //通过类名.books-activities获取
    //子级标签里的类名属性.book-activity获取
    //返回一个Element列表对象
    List<Element> aEls =
        doc.querySelectorAll('.books-activities .book-activity');

    //返回所有活动的属性列表
    List<Activity> activities = [];

    // 遍历列表对象
    for (var element in aEls) {
      //网址
      String url = element.attributes['href']?.trim() ?? "";

      //通过 style属性标签 再根据正则表达式获取到活动封面背景图
      String cover =
          ApiString.getBookActivityCover(element.attributes['style']);

      //活动标题 通过类名拿到标签 在通过text属性获得innerHTML 然后使用 trim 方法把两边的空格给去掉
      //<p class="book-activity-title">我们知晓自身的分裂，但无法解释原因｜《梦游人》线上共读会</p>
      String title =
          element.querySelector('.book-activity-title')?.text.trim() ?? "";

      //读书活动的类型
      String label =
          element.querySelector('.book-activity-label')?.text.trim() ?? "";

      //读书活动的时间
      String time =
          element.querySelector('.book-activity-time')?.text.trim() ?? "";

      activities.add(
        Activity(
          url: url,
          cover: cover,
          title: title,
          label: label,
          time: time,
        ),
      );
    }
    return activities;
  }

  /// 解析首页书籍数据
  List<Book> parseHomeBooks(Document doc) {
    //只获取一页
    //获取书籍数组里的第二组
    Element ulEl = doc.querySelectorAll('.books-express .bd .slide-item')[1];
    //再拿第二个 ul 下面的所有 li 遍历所有的 li
    List<Element> liEls = ulEl.querySelectorAll('li');

    List<Book> books = [];

    for (Element li in liEls) {
      Element? a = li.querySelector('.cover a');
      //定义一个方法从 url 中截取书籍的 id
      //解析 id
      String id =
          ApiString.getBookId(a?.attributes['href'], ApiString.bookIdRegExp);
      String cover = a?.querySelector('img')?.attributes['src'] ?? "";
      books.add(
        Book(
          id: id,
          cover: cover,
          title: li.querySelector('.info .title a')?.text.trim() ?? "",
          authorName: li.querySelector('.info .author')?.text.trim() ?? "",
        ),
      );
    }

    return books;
  }

/*
  /// 获取首页数据
  Future<List<Activity>> fetchHomeData() async {
    // 返回是字符串类型的一个完整的 DOM 树
    // 通过它解析到里面的 HTML 节点属性
    String htmlStr = await DioInstance.instance()
        .getString(path: ApiString.bookDoubanHomeUrl);

    //这个方法返回Document对象就跟 js 里面的Document对象类似的
    Document doc = parse(htmlStr);

    //通过类名.books-activities获取
    //子级标签里的类名属性.book-activity获取
    //返回一个Element列表对象
    List<Element> aEls =
        doc.querySelectorAll('.books-activities .book-activity');

    //返回所有活动的属性列表
    List<Activity> activities = [];

    // 遍历列表对象
    for (var element in aEls) {
      //网址
      String url = element.attributes['href']?.trim() ?? "";

      //通过 style属性标签 再根据正则表达式获取到活动封面背景图
      String cover =
          ApiString.getBookActivityCover(element.attributes['style']);

      //活动标题 通过类名拿到标签 在通过text属性获得innerHTML 然后使用 trim 方法把两边的空格给去掉
      //<p class="book-activity-title">我们知晓自身的分裂，但无法解释原因｜《梦游人》线上共读会</p>
      String title =
          element.querySelector('.book-activity-title')?.text.trim() ?? "";

      //读书活动的类型
      String label =
          element.querySelector('.book-activity-label')?.text.trim() ?? "";

      //读书活动的时间
      String time =
          element.querySelector('.book-activity-time')?.text.trim() ?? "";

      activities.add(
        Activity(
          url: url,
          cover: cover,
          title: title,
          label: label,
          time: time,
        ),
      );
    }
    return activities;
  }
  
  */
}
