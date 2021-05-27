import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/data/news_api.dart';
import 'package:news_app/model/artical.dart';
import 'package:news_app/views/home_page.dart';
import 'package:news_app/widget/colors.dart';
import 'package:news_app/widget/tob_bar.dart';

class AwsomeBottomNavigation extends StatefulWidget {
  final colors = [
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.green,
    Colors.cyan,
    Colors.green,
    Colors.cyan,
  ];
  final icons = [
    CupertinoIcons.home,
    CupertinoIcons.phone,
    CupertinoIcons.location,
    CupertinoIcons.info,
    CupertinoIcons.profile_circled,
    CupertinoIcons.info,
    CupertinoIcons.profile_circled
  ];
  final titles = [
    'الأعمال',
    'الترفية',
    'عامة',
    'الصحة',
    'العلوم',
    'الرياضة',
    'تكنولوجيا',
  ];
  final List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  @override
  _AwsomeBottomNavigationState createState() => _AwsomeBottomNavigationState();
}

class _AwsomeBottomNavigationState extends State<AwsomeBottomNavigation> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDraggin = false;

  int currentIndex = 0;
  @override
  void initState() {
    fetchData(widget.categoryList.first);
    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handelPageChange);
    super.initState();
  }

  Future<List<Article>> articles;
  void fetchData(String cat) {
    articles = NewsApi().fetchArticles(cat);
  }

  void handelPageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDraggin = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDraggin = false;
    }
    if (userPageDraggin) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollerNotificatio) {
            checkUserDragging(scrollerNotificatio);
            return userPageDraggin;
          },
          child: Column(
            children: [
              Stack(
                children: [
                  TopBar(),
                  Positioned(
                    top: 30.0,
                    right: 0.0,
                    left: 0.0,
                    child: Text("أخبار  ${widget.titles[currentIndex]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  )
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: widget.categoryList.map((e) {
                    fetchData(e);
                    return Homepage(
                      articles: articles,
                    );
                  }).toList(),
                  onPageChanged: (index) {
                    updateCurrentIndex(index);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: firstColor.withOpacity(0.8),
          defaultBubbleColor: Colors.purple,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutQuad);
            updateCurrentIndex(index);
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var color = widget.colors[index];
            return BubbledNavigationBarItem(
                icon: getIcon(index, color),
                activeIcon: getIcon(index, Colors.white),
                bubbleColor: Colors.purple,
                title: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ));
          }).toList(),
        ));
  }

  void updateCurrentIndex(int index) {
    return setState(() {
      currentIndex = index;
    });
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, right: 10, left: 10),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}
