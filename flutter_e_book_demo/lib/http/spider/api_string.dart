// 定义一些基础的网址

class ApiString {
  //
  static const String bookActivitiesJsonUrl = "https://book.douban.com/j/home/activities";
  // 豆瓣首页
  static const String bookDoubanHomeUrl = "https://book.douban.com/";
  // 获取背景图片正则表达式
  static const String bookActivityCoverReg = r"https:.*(?='\))";
  // 获取书籍id
  static const String bookIdRegExp = r"(?<=/subject/)\d+(?=/)";

  // 写一个工具 从 style属性里面提取背景图片的 url
  static String getBookActivityCover(String? style) {
    if (style == null || style.isEmpty) return "";
    //使用正则表达式获取 背景图片url
    return RegExp(bookActivityCoverReg).stringMatch(style) ?? "";
  }

  //获取书籍 id
  static String getBookId(String? content, String reg) {
    if (content == null || content.isEmpty) return "";
    //使用正则表达式从 url 中获取 书籍 id
    return RegExp(reg).stringMatch(content) ?? "";
  }
}

