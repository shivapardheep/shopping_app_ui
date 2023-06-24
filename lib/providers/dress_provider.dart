import 'package:flutter/cupertino.dart';

import '../constants/datas.dart';
import '../models/dress_model.dart';

class DressProvider extends ChangeNotifier {
  List<Dress> _dressList = sampleDresses;
  bool _imageIsSelected = false;

  List<Dress> get getDressList => _dressList;
  bool get getImageIsSelected => _imageIsSelected;

  addDress(Dress item) {
    _dressList.add(item);
    print(_dressList.last.imageUrl);
    notifyListeners();
  }

  imageSelectFun(value) {
    _imageIsSelected = value;
    notifyListeners();
  }
}
