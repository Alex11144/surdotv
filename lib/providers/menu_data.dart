import 'package:flutter/material.dart';


class MenuData with ChangeNotifier {
 int _selectedMenuIndex = 0;
 String _selectedCategoryId = '';
  
int  get selectedMenuIndex=> _selectedMenuIndex; 
String  get selectedCategoryId=> _selectedCategoryId; 

void setCategoryId(String id) {
  _selectedCategoryId = id;
  notifyListeners();
}

void setMenuIndex(int index) {
  _selectedMenuIndex = index;
  notifyListeners();
}

}
