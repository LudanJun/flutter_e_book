import 'package:flutter/material.dart';

class DoubanStorePage extends StatefulWidget {
  const DoubanStorePage({super.key});

  @override
  State<DoubanStorePage> createState() => _DoubanStorePageState();
}

class _DoubanStorePageState extends State<DoubanStorePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("豆瓣商城"),
    );
  }
}
