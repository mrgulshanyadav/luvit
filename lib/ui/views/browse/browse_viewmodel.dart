import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:luvit/app/app.logger.dart';
import 'package:luvit/model/user/user_model.dart';
import 'package:luvit/utils/asset_helper.dart';
import 'package:stacked/stacked.dart';

class BrowseViewModel extends BaseViewModel {
  final log = getLogger('BrowseViewModel');
  //final _userService = locator<UserService>();

  CarouselController carouselController = CarouselController();
  UserModel get fakeUser => fakeUsers.first;

  List<UserModel> get getFakeUsers => fakeUsers;
  List<String> _images = [];
  List<String> get images => _images;

  double get dxValue => _dxValue;
  double get dyValue => _dyValue;
  double _dxValue = 0;
  double _dyValue = 0;

  int _imageOnScreenIndex = 0;
  int get imageOnScreenIndex => _imageOnScreenIndex;

  bool isImageOnScreen(index) => index == imageOnScreenIndex;
  bool hasHeartEmoji(String text) => text.contains('💖');

  void onInit() {
    _images = [...fakeUser.imagePaths];
    notifyListeners();
  }

  void onTapTopLeft() {
    if (_imageOnScreenIndex != 0) {
      _imageOnScreenIndex--;
      animateToPage(_imageOnScreenIndex);
    }
    notifyListeners();
  }

  void onTapTopRight() {
    if (_imageOnScreenIndex != images.length - 1) {
      _imageOnScreenIndex++;
      animateToPage(_imageOnScreenIndex);
    }
    notifyListeners();
  }

  void animateToPage(int index) {
    carouselController.animateToPage(index,
        duration: const Duration(milliseconds: 1), curve: Curves.linear);
    notifyListeners();
  }

  void onPageChange(int index) {
    _imageOnScreenIndex = index;
    notifyListeners();
  }

  void onDragComplete() {
    if ((dxValue < -0.2 && dyValue <= 0) || (dyValue > 0.2 && dxValue <= 0)) {
      _images.removeAt(_imageOnScreenIndex);
    }
    if (images.length == 1) {
      _imageOnScreenIndex = 0;
    }
    _dxValue = 0;
    _dyValue = 0;
    notifyListeners();
  }

  void onDragUpdate(DragUpdateDetails details) {
    _dxValue = details.delta.dx;
    _dyValue = details.delta.dy;

    log.d(_dxValue);
    log.d(_dyValue);
    notifyListeners();
  }

  String getDescription(String path) {
    switch (path) {
      case image1:
        return ' 2km 거리에 있음';
      case image2:
        return fakeUser.bio;
      case image3:
        return '2km 거리에 있음';

      default:
        return '';
    }
  }
}
