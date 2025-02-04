import 'package:child_community/helper/ui_helper/overlay_helper.dart';
import 'package:child_community/ui/view/bookmarks/view/screen/bookmark_screen.dart';
import 'package:child_community/ui/view/home/data/repo/home_repo.dart';
import 'package:child_community/ui/view/home/view/screen/home_screen.dart';
import 'package:child_community/ui/view/message/view/screen/message_screen.dart';
import 'package:child_community/ui/view/post_activity/view/screen/post_activity_screen.dart';
import 'package:child_community/ui/view/profile/view/screen/profile_screen.dart';
import 'package:child_community/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController  implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});


  PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final List<ScreenModel> _screens = [
    ScreenModel(const HomeScreen(), 'Home', AllImages.home),
    ScreenModel(const MessageScreen(), 'Message', AllImages.home),
    ScreenModel(const PostActivityScreen(), 'Post Activity', AllImages.home),
    ScreenModel(const BookmarkScreen(), 'Bookmarks', AllImages.home),
    ScreenModel(const ProfileScreen(), 'Profile', AllImages.home),
  ];
  List<ScreenModel> get screen => _screens;

  initPageController(){
    _pageController = PageController(initialPage: 0);
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  setPageIndex(int index){
    _pageIndex = index;
  }
  void setPage(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
    _pageIndex = pageIndex;
    update();
  }

  /// for network calling
  bool _isNetworkConnected = true;
  bool get isNetworkConnected  => _isNetworkConnected;

  void setIsNetworkConnected(bool event, BuildContext context) {
    if(event){
      OverlayManager.hideOverlay();
    }else{
      OverlayManager.showOverlay(context);
    }

    _isNetworkConnected = event;
    update();

  }

}



class ScreenModel{
  Widget? screen;
  String? name;
  String? icon;
  ScreenModel(this.screen, this.name, this.icon);
}