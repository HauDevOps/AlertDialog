import 'package:flutter/cupertino.dart';
import 'package:flutter_app/dataCountry.dart';

class SingleNotifier extends ChangeNotifier{
  String _currentCountry = country[0];
  SingleNotifier();

  String get currentCountry => _currentCountry;

  updateCountry(String value){
    if(value != _currentCountry){
      _currentCountry = value;
      notifyListeners();
    }
  }
}

class MultipleNotifier extends ChangeNotifier{
  List<String> _selectedItem;
  MultipleNotifier(this._selectedItem);
  List<String> get selecttfItems => _selectedItem;

  bool isHaveItem(String value) => _selectedItem.contains(value);

  addItem(String value){
    if(!isHaveItem(value)){
      _selectedItem.add(value);
      notifyListeners();
    }
  }

  removeItem(String value){
    if(!isHaveItem(value)){
      _selectedItem.remove(value);
      notifyListeners();
    }
  }
}