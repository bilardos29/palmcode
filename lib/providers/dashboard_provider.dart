import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int page = 0;

  void changePage(int page){
    this.page = page;
    notifyListeners();
  }

  void logout(){
    page = 0;
    notifyListeners();
  }
}