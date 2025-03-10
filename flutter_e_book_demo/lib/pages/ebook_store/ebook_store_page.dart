import 'package:flutter/material.dart';

class EbookStorePage extends StatefulWidget {
  const EbookStorePage({super.key});

  @override
  State<EbookStorePage> createState() => _EbookStorePageState();
}

class _EbookStorePageState extends State<EbookStorePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("ebook 商城"),
    );
  }
}