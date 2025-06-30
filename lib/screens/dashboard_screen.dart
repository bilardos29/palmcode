import 'package:flutter/material.dart';
import 'package:palmcode/providers/dashboard_provider.dart';
import 'package:palmcode/screens/home_screen.dart';
import 'package:palmcode/screens/liked_books_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/menu_icon.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardProvider controller = context.watch<DashboardProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.page == 0
          ? HomeScreen()
          : controller.page == 1
          ? LikedBooksScreen()
          : Container(),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MenuIcon(
                    icons: Icons.home,
                    menu: 'Home',
                    isActive: controller.page == 0,
                    onClick: () {
                      setState(() {
                        controller.page = 0;
                      });
                    }),
                MenuIcon(
                    icons: Icons.favorite,
                    menu: 'Likes',
                    isActive: controller.page == 1,
                    onClick: () {
                      setState(() {
                        controller.page = 1;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
