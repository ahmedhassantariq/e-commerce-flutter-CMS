import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/homePageSettings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomePageSettings();
  }
}
