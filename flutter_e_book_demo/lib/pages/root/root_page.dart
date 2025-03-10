import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/pages/douban_store/douban_store_page.dart';
import 'package:flutter_e_book_demo/pages/ebook_store/ebook_store_page.dart';
import 'package:flutter_e_book_demo/pages/home/home_page.dart';
import 'package:flutter_e_book_demo/pages/my_ebook/my_book_page.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  List rootApp = [
    {
      "icon": LineIcons.home,
      "text": "首页",
    },
    {
      "icon": LineIcons.book,
      "text": "首页",
    },
    {
      "icon": LineIcons.shoppingBag,
      "text": "电子书城",
    },
    {
      "icon": LineIcons.heart,
      "text": "我的",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: _getBottomNavigator(context),
      body: LazyLoadIndexedStack(
        index: _index,
        children: const [
          HomePage(),
          DoubanStorePage(),
          EbookStorePage(),
          MyBookPage(),
        ],
      ),
    );
  }

  Widget _getBottomNavigator(BuildContext context) {
    ///通过第三方差距添加底部 tabBar
    return SalomonBottomBar(
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
      },
      items: List.generate(
        rootApp.length,
        (index) {
          return SalomonBottomBarItem(
            ///选择的颜色
            selectedColor: Theme.of(context).colorScheme.onSurface,

            ///未选择的颜色
            unselectedColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(rootApp[index]['icon']),
            title: Text(rootApp[index]['text']),
          );
        },
      ),
    );
  }
}
